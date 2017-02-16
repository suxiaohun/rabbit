class Sys::CommonController < ApplicationController
  #login有单独的layout
  layout 'login', :only => [:login]

  def index


  end

  def test

  end


  def login_out

  end

  def login
    if request.get?
      #重置session,#注销用户
      # reset_session
      Sys::Session.sweep('20 minutes')
      Sys::User.current=nil
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
    #TODO 登录成功,记录日志
    redirect_to({:controller => 'common', :action => 'index'})
  end

end
