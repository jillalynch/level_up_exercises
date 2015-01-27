# run `ruby overlord.rb` to run a web server for this app

require 'sinatra'
require 'rack'

enable :sessions
# use Rack::Flash

set :codes #, {}

class Overlord < Sinatra::Application

  get '/' do
    "Hello World"
  end

  get '/' do
    puts erb "Hello Jill"
    puts erb bomb.state
  end

  # get '/activate' do
  #   erb bomb.state
  #   bomb.enter_code(params['activation_code'])
  # end
  #
  # post '/activate' do
  #   bomb.enter_code(params['activation_code'])
  #   redirect to('/')
  # end
  #
  # post '/deactivate' do
  #   bomb.enter_code(params['deactivation_code'])
  #   redirect to('/')
  # end
  #
  # not_found do
  #   erb "Page is not found"
  # end

  # get '/new' do
  #   session[:bomb] = Bomb.new(settings.codes)
  #   redirect to('/')
  # end

  private

  def bomb
    session[:bomb] ||= Bomb.new(settings.codes)
  end

end
