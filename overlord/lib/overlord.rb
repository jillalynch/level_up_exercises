require 'sinatra'
require 'rack'
require 'shotgun'
require 'erb'
require 'rack-flash'
require 'json'
require_relative('bomb')

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

get "/get_state" do
  { error: "Hey error here", state: bomb.state, }.to_json
end

post "/code_entry" do
  bomb.enter_code(params[:code])
  {
    error: "Hey error here",
    state: bomb.state,
  }.to_json
end

not_found do
  erb "Page is not found"
end

private

def bomb
  session[:bomb] ||= Bomb.new
end

def valid_code?(code)
  code.numeric? && (code.length == 4)
end


class String
  def numeric?
    /^\d{4}$/ === self
  end
end