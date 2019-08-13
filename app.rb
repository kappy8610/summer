require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require './models/absent.rb'
require './models/admin.rb'
require './models/attendance.rb'
require './models/belong.rb'
require './models/day.rb'
require './models/user.rb'

enable :method_override

# トップページ
get '/' do
  erb :index
end

# ログインページ
get '/login' do
  erb :login
end

# 新規登録ページ
get '/sign_up' do
  erb :sign_up
end

# 新規出席表作成ページ
get '/new' do
  erb :new
end

# 新規出席表制作処理
post '/new_attendance' do
  new_attendance_params = {
    name: params[:name]
  }
  attendance = Attendance.new(new_attendance_params)
  attendance.save
  redirect '/'
end

# 一般ユーザーの新規登録処理
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

# 管理者の新規登録処理
post '/sign_up_admin' do
  sign_up_admin_params = {
    name: params[:name],
    email: params[:email],
    password: params[:password]
  }
  admin = Admin.new(sign_up_admin_params)
  admin.save
  redirect '/users'
end

# ユーザー一覧ページ
get '/users' do
  @user = User.all
  erb :users
end

# 各ユーザーの情報ページ
get '/:id' do
  @user = User.find(params[:id])
  erb :user
end

# 各ユーザーの出席申請
post '/:id' do
  @user = User.find(params[:id])
  @user.is_attendance = true
  @user.save
  erb :user
end

# 出席表一覧
get '/:id/join' do
  @attendance = Attendance.all
  erb :join
end

# 出席表への参加処理
post '/:id/join' do
  @user.attendance = Attendance.find(params[:name])
end

configure do
  set :server, :puma
end
