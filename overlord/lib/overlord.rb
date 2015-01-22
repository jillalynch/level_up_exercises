# run `ruby overlord.rb` to run a web server for this app

require 'sinatra'
require_relative 'functions'
require 'rack'

enable :sessions
# use Rack::Flash

class Overlord < Sinatra::Application
  get '/' do
    "Time to build an app around here. Start time: " + start_time
  end

  get '/activate' do
    "Time to build an app around here. Start time: " + start_time
  end

  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end
end
