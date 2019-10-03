require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require "time"

require './models/absent.rb'
require './models/attendance.rb'
require './models/belong.rb'
require './models/day.rb'
require './models/user.rb'
require './models/today.rb'

enable :method_override

init = true

# トップページ
get '/' do
  @title = "トップページ"
  @time = Time.new
  if init then
    today = Today.create!(month_at: @time.month, day_at: @time.day, year_at: @time.year)
    init = false
  end
  erb :index
end

# 新規登録ページ
get '/sign_up' do
  @title = "新規登録"
  @belongs = Belong.all
  @time = Time.new  
  erb :sign_up
end

# ログインページ
get '/login' do
  @title = "ログイン"
  erb :login
end

# 出席確認ページ
get '/table' do
  @time = Time.new
  @title = "#{@time.month}月の出席確認"
  @user = User.all
  @today = Today.find(1)
  erb :table
end

# 日付変更処理
post '/table' do
  @time = Time.new
  user = User.all
  today = Today.find(1)
  if today.day_at != @time.day || today.month_at != @time.month || today.year_at != @time.year then
    day_params = {
      year_at: params[:year_at],
      month_at: params[:month_at],
      day_at: params[:day_at]
    }
    today.update(day_params)

    user = User.all
    user.each do |user|
      attendance = Attendance.create!(user_id: user.id, 
                                      day_at: today.day_at, 
                                      month_at: today.month_at,
                                      year_at: today.year_at)
      attendance.save
    end
  end

  redirect '/table'
end

# 欠席連絡確認ページ
get '/chack_absent' do
  @title = "欠席連絡一覧"
  @absents = Absent.all
  erb :chack_absent
end

# 新規所属グループ作成ページ
get '/belong' do
  @title = "新規所属グループ作成"
  erb :belong
end

# 新規出席表制作処理
post '/new_attendance' do
  @title = "トップページ"
  @time = Time.new
  new_attendance_params = {
    name: params[:name]
  }
  attendance = Attendance.new(new_attendance_params)
  attendance.save
  redirect '/'
end

# 一般ユーザーの新規登録処理
post '/sign_up' do
  today = Today.find(1)
  sign_up_params = {
    name: params[:name],
    belong_id: params[:belong_id],
    email: params[:email],
    password: params[:password],
  }
  user = User.new(sign_up_params)
  user.save
  attendance = Attendance.create!(user_id: user.id, 
                                  day_at: today.day_at, 
                                  month_at: today.month_at,
                                  year_at: today.year_at)
  attendance.save
  redirect '/users'
end

# 新規所属グループ作成処理
post '/new_belong' do
  @title = "トップページ"
  belong_params = {
    name: params[:name]
  }
  belong = Belong.new(belong_params)
  belong.save
  redirect '/'
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

# 各ユーザーの欠席連絡一覧
get '/:id/list' do
  @user = User.find(params[:id])
  @title = "#{@user.name}の欠席連絡一覧"
  erb :absent_list
end

# 新規欠席連絡
post '/:id/new_absent' do
  @title = "トップページ"
  @user = User.find(params[:id])
  absent_params = {
    user_id: params[:user_id],
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
  @attendance = Attendance.find_by(user_id: @user.id, day_at: @day.day, month_at: @day.month, year_at: @day.year)
  p "________#{@attendance.is_attendance}*****"
  erb :user
end

# 各ユーザーの出席申請
post '/:id' do
  @day = Time.new
  @title = "ユーザー情報"
  @user = User.find(params[:id])
  @user.attendance_num += 1
  @attendance = Attendance.find_by(user_id: @user.id, day_at: @day.day, month_at: @day.month, year_at: @day.year)
  @attendance.is_attendance = true
  @user.save
  @attendance.save
  erb :user
end

# 各ユーザーの編集ページ
get '/:id/edit' do
  @user = User.find(params[:id])
  @belongs = Belong.all
  @title = "ユーザー情報の編集"
  erb :edit
end

# 各ユーザーの編集処理
post '/:id/edit' do
  edit_params = {
    name: params[:name],
    belong_id: params[:belong_id],
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
