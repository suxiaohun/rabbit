class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :check_if_require_login


# 检查是否需要登录
  def check_if_require_login
    # 如果session中存在user_id,则无需登录,否则转向登录页面
    if session[:user_id]
      #如果会话存在，则设置current_user（防止Sys::User.current失效）
      Sys::User.current = Sys::User.find(session[:user_id])
      true
    else
      require_login
    end
  end


#判断是否需要登录
  def require_login
    url = ''
    # if request.get?
    #   url = url_for params
    # end
    # 防止在login页面进入循环跳转
    if params[:controller].eql?('sys/common')&&params[:action].eql?('login')
      true
    else
      redirect_to({:controller => 'sys/common', :action => 'login', :back_url => url})
    end
  end


end
