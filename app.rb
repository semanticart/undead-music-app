require 'rubygems'
require 'i18n'
require 'rest_client'
require 'yaml'
require 'json'
require 'ftools'
require 'sinatra'
require 'scrobbler'

%w( artist_extractor artist_api last_fm_extractor itunes_extractor ).each do |file|
  require "lib/#{file}"
end

configure do
  CONFIG = YAML.load(File.read("config.yml"))
end

helpers do
  def link_out url, text, title = url
    %(<a target="_blank" href="#{url}" title="#{title}">#{text}</a>)
  end

  def link_text(link)
    text = domain(link)
    text << %( (#{link['count']})) if link['count'].to_i > 0
  end

  def archive_link?(link)
    domain(link) == "archive.org"
  end

  def domain(link)
    @domains ||= {}
    @domains[link] ||= URI.parse(link['url']).host.scan(/^.*?([^.]+\.[^.]+)$/)[0][0].downcase
  end

  def unique_token
    token = ""
    # sure, these collisions are unlikely
    while ['', 'upload', 'lastfm', 'about'].include?(token) or File.exist?("tmp/#{token}.xml")
      token = rand(36**8).to_s(36)
    end
    token
  end

  def artist_count size
    [size.to_s, (size == 1 ? "match" : "matches")].join(' ')
  end

  def recording_count matches
    count = matches.inject(0) do |sum, match|
      sum + match['links'].inject(0) do |sum, link|
        sum + link['count'].to_i
      end
    end
    [count.to_s, (count == 1 ? "recording" : "recordings")].join(' ')
  end

  def calculate_matches_for input
    @extractor = ArtistExtractor.for(input)
    @matches = @extractor.matches
    if @matches.size > 0
      erb :matches
    else
      erb :no_matches
    end
  end
end

not_found do
  @msg ||= "File Not Found"
  erb :"404"
end

get '/' do
  erb :index
end

get '/about' do
  erb :about
end

post '/lastfm' do
  if params[:user] && !params[:user].empty?
    redirect("/lastfm/#{params[:user]}")
  else
    @msg = "You must provide some input"
    raise Sinatra::NotFound
  end
end

get '/lastfm/:id' do
  calculate_matches_for(Scrobbler::User.new(params[:id]))
end

post '/upload' do
  token = unique_token
  begin
    File.move(params[:library][:tempfile].path, "tmp/#{token}.xml")
    redirect("/#{token}")
  rescue
    @msg = (params[:library] ? "There was a problem with your upload." : "You didn't select a file.")
    raise Sinatra::NotFound
  end
end

get '/:token' do
  # this escaping should be unnecessary since the route shouldn't match
  # otherwise, but let's be careful
  file_name = "tmp/#{params[:token].gsub(/[^\w]/, '')}.xml"

  if File.exist?(file_name)
    calculate_matches_for(File.new(file_name))
  else
    raise Sinatra::NotFound
  end
end

