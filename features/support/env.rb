ENV['RACK_ENV'] = 'test'

# See http://wiki.github.com/aslakhellesoy/cucumber/sinatra
# for more details about Sinatra with Cucumber

gem 'rack-test', '>=0.5.0'
gem 'sinatra', '=0.9.4'

app_file = File.join(File.dirname(__FILE__), *%w[.. .. app.rb])
require app_file
# Force the application name because polyglot breaks the auto-detection logic.
Sinatra::Application.app_file = app_file

require 'spec/mocks'
require 'spec/expectations'
require 'rack/test'
require 'webrat'
require 'scrobbler'

require File.dirname(__FILE__)+ "/../../spec/spec_helper.rb"

Webrat.configure do |config|
  config.mode = :rack
end

class MyWorld
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
  include Webrat::HaveTagMatcher

  def app
    Sinatra::Application
  end
end

World{MyWorld.new}

