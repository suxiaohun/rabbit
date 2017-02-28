class Sys::CommonController < ApplicationController

  protect_from_forgery :except => [:login]
  skip_before_action :set_current_menu, :only => [:login, :login_out]
  skip_before_action :check_if_require_login, :only => [:login, :login_in, :login_out]

  #login有单独的layout
  layout 'login', :only => [:login]

  def index

  end


  def login_in
    login_authentication
  end


  def login_out
    redirect_to :action => 'login'
  end

  def login
    if request.get?
      Sys::Session.sweep('20 minutes')
      Sys::User.current = nil
      #重置session,#注销用户
      reset_session
    else
      login_authentication
    end
  end


  private
  #验证用户登录是否成功
  #成功,则转向用户的默认页面
  #失败,返回原来的页面,并显示登录出错的消息
  def login_authentication
    username = params[:username].strip
    password = params[:password].strip
    begin
      raise '账号/密码不能为空' if username.blank? || password.blank?
      user, msg = Sys::User.try_login(username, password)

      if user
        #登录成功
        successful_authentication(user)
      else
        #TODO 登录失败,记录错误日志
        params[:error]=msg
      end
    rescue Exception => e
      params[:error] = e.message.to_s
    end
  end

  #登录成功则返回到默认页面
  def successful_authentication(user)
    #设置当前登录用户
    Sys::User.current = user
    session[:user_id] = user.id

    # byebug
    #TODO 登录成功,记录日志
    redirect_to({:controller => 'common', :action => 'index'})
  end


end
