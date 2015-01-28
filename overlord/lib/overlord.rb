require 'sinatra'
require 'rack'
require 'shotgun'
require 'erb'
require 'rack-flash'
require_relative('bomb')

class Overlord < Sinatra::Base

  enable :sessions
  set :haml, format: :html5

  use Rack::Flash

  get "/boot" do
    haml(:boot)
  end

  post "/boot" do
    activation_code   = params[:activation_code]
    deactivation_code = params[:deactivation_code]

    return haml(:boot) unless valid_code?(activation_code) && valid_code?(deactivation_code)

    bomb.activation_code   = activation_code
    bomb.deactivation_code = deactivation_code
    redirect "/bomb"
  end

  get "/bomb" do
    flash[:notice] = "Thanks for signing up!"
    @bomb          = bomb

    haml(:bomb)
  end

# get '/activate/:activation_code' do
#   bomb.enter_code(params['activation_code'])
#   "You said #{params[:activation_code]} Bomb state #{bomb.state}"
# end
#
# post '/deactivate' do
#   bomb.enter_code(params['deactivation_code'])
#   redirect to('/')
# end

  not_found do
    erb "Page is not totally found"
  end

# private

  def bomb
    session[:bomb] ||= Bomb.new
  end

  def valid_code?(code)
    code.numeric? && (code.length == 4)
  end
end

class String
  def numeric?
    /^\d{4}$/ === self
  end
end