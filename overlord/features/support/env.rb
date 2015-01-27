$LOAD_PATH << File.expand_path('../../../lib', __FILE__)

require 'overlord'
require 'rspec'
require 'sinatra'

begin require "rspec/expectations"
rescue LoadError
  require "spec/expectations"
end

require "rack/test"
require "capybara/cucumber"
require "capybara-webkit"

Capybara.app = Overlord
Capybara.default_driver = :rack_test
Capybara.javascript_driver = :webkit