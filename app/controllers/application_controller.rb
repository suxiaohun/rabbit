class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery prepend: true

  before_action :check_if_require_login
  #TODO 在进行以下动作时，首先需要判断url是否合法
  # before_action :check_permission
  before_action :set_current_menu


  def set_current_menu(controller=params[:controller], action=params[:action])
    # url_options = {:controller => controller, :action => action}

    current_menu = Sys::Permission.get_by_url(controller, action).first

    #解决未正确在配置文件中配置function/menu，从而查询不到菜单，系统会报错的问题（暂时默认使用首页菜单）
    current_menu = Sys::Permission.get_by_url('sys/common', 'index').first if current_menu.blank?
    Sys::Menu.current_menu = current_menu
    Sys::Tab.current_tab = Sys::Menu.where(:recursion_code => current_menu.recursion_code[0, 3]).first

    # permission = Sys::Permission.where(:controller=>controller,:action=>action).first
    # sql = 'select m.code menu_code,m.parent_code   from sys_permissions p left join
    #        sys_functions f on p.function_code=f.code left join sys_menus m on f.menu_code=m.code ;'
    #
    # result = Sys::Menu.find_by_sql(sql)
    # byebug
    # Sys::Menu.current_menu_code = result.menu_code
  end


  #检查是否需要登录
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

    redirect_to({:controller => 'sys/common', :action => 'login', :back_url => 'url'})

    # byebug
    # url = ''
    # # if request.get?
    # #   url = url_for params
    # # end
    # # 防止在login页面进入循环跳转
    # if params[:controller].eql?('sys/common')&&params[:action].eql?('login')
    #   true
    # else
    #   redirect_to({:controller => 'sys/common', :action => 'login', :back_url => url})
    # end
  end


end
