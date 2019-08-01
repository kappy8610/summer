require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require './models/user.rb'

enable :method_override

get '/' do
  erb :index
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  sign_up_params = {
    name: params[:name],
    email: params[:email],
    password: params[:password]
  }
  user = User.new(sign_up_params)
  user.save
  redirect '/users'
end

get '/users' do
  @user = User.all
  erb :users
end

get '/:id' do
  @user = User.find(params[:id])
  erb :user
end

configure do
  set :server, :puma
end
