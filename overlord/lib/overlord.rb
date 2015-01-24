# run `ruby overlord.rb` to run a web server for this app

require 'sinatra'
require_relative 'functions'
require 'rack'

enable :sessions
# use Rack::Flash

set :codes, {}

class Overlord < Sinatra::Application

  get '/' do
    "Time to build an app around here. Start time: " + start_time
    erb bomb.state
  end

  post '/activate' do
    bomb.activate(params['activation-code'])
    redirect to('/')
  end

  post '/deactivate' do
    bomb.deactivate(params['deactivation-code'])
    redirect to('/')
  end

  # get '/new' do
  #   session[:bomb] = Bomb.new(settings.codes)
  #   redirect to('/')
  # end

  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  def bomb
    session[:bomb] ||= Bomb.new(settings.codes)
  end
end
