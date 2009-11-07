require 'rubygems'
require 'spec'
require 'scrobbler'
require 'rest_client'

%w( artist_extractor artist_api last_fm_extractor itunes_extractor ).each do |file|
  require File.dirname(__FILE__)+ "/../lib/#{file}"
end

ITUNES_LIBRARY_FILE = File.dirname(__FILE__)+ "/iTunesLibrary.xml"

LASTFM_SAMPLE = {
  :top_artists    => YAML.load(File.read(File.dirname(__FILE__)+ "/lastfm_top_artist_sample.yml")),
  :recent_tracks  => YAML.load(File.read(File.dirname(__FILE__)+ "/lastfm_recent_sample.yml"))
}

MB_SAMPLE = {
  :pink_floyd         => YAML.load(File.read(File.dirname(__FILE__)+ "/mb_pink_floyd.yml")),
  :steve_johnson_band => YAML.load(File.read(File.dirname(__FILE__)+ "/mb_steve_johnson_band.yml"))
}

CONFIG = {:api_url => "http://localhost:4444"}
