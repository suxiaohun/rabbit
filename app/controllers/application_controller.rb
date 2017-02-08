class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :check_if_require_login

  helper_method :current_user

  # 检查是否需要登录
  def check_if_require_login
    # 如果用户已经登录,则无需登录,否则转向登录页面
    if Sys::User.current
      true
    else
      require_login
    end
  end


  #判断是否需要登录
  def require_login
    url = ''
    if request.get?
      url = url_for params.permit!
    end

    # 防止在login页面进入循环跳转
    if params[:controller].eql?('sys/common')&&params[:action].eql?('login')
      true
    else
      redirect_to({:action => 'login', :back_url => url})
    end
  end



end
