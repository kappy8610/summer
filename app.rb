require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require "time"

require './models/absent.rb'
require './models/admin.rb'
require './models/attendance.rb'
require './models/belong.rb'
require './models/day.rb'
require './models/user.rb'

enable :method_override

# トップページ
get '/' do
  @title = "トップページ"
  erb :index
end

# 新規登録ページ
get '/sign_up' do
  @title = "新規登録"
  erb :sign_up
end

# ログインページ
get '/login' do
  @title = "ログイン"
  erb :login
end

# 出席確認ページ
get '/table' do
  @day = Time.new
  @title = "#{@day.year}年#{@day.month}月#{@day.day}日の主席確認"
  @user = User.all
  erb :table
end

# 欠席連絡確認ページ
get '/chack_absent' do
  @title = "欠席連絡一覧"
  @absent = Absent.all
  erb :chack_absent
end

# 新規出席表制作処理
post '/new_attendance' do
  @title = "トップページ"
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
  @title = "ユーザー一覧"
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
  @title = "ユーザー一覧"
  @day = Time.new
  @last_login_day = @day
  @user = User.all
  erb :users
end

# 欠席申請
get '/:id/absent' do
  @title = "欠席申請"
  @user = User.find(params[:id])
  erb :absent
end

# 新規欠席連絡
post '/:id/new_absent' do
  @title = "トップページ"
  @user = User.find(params[:id])
  absent_params = {
    name: params[:name],
    when: params[:when],
    reason: params[:reason]
  }
  absent = Absent.new(absent_params)
  absent.save
  redirect '/'
end

# 各ユーザーの情報ページ
get '/:id' do
  @user = User.find(params[:id])
  @title = "ユーザー情報"
  @day = Time.new
  erb :user
end

# 各ユーザーの出席申請
post '/:id' do
  @user = User.find(params[:id])
  @user.is_attendance = true
  @user.attendance_num += 1
  @user.save
  @day = Time.new
  @title = "ユーザー情報"
  erb :user
end

# 各ユーザーの編集ページ
get '/:id/edit' do
  @user = User.find(params[:id])
  @title = "ユーザー情報の編集"
  erb :edit
end

# 各ユーザーの編集処理
post '/:id/edit' do
  edit_params = {
    name: params[:name],
    email: params[:email],
    password: params[:password]
  }
  @user = User.find(params[:id])
  @user.update(edit_params)
  @user.save
  redirect "/#{params[:id]}"
end

configure do
  set :server, :puma
end
