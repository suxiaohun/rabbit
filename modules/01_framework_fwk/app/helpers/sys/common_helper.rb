module Sys::CommonHelper

  def navigation_tabs
    tabs = Sys::Tab.all
    tds = ''
    tabs.each do |tab|
      next unless tab.fav_menu_code == '11'
      style = ''
      if tab.code == Sys::Tab.current_tab.code
        style = 'tab-div current'
      else
        style = 'tab-div'
      end
      # tds << content_tag(:div, content_tag(:div, link_to(tab.name, {:controller => tab.fav_menu_controller, :action => tab.fav_menu_action, :code => tab.code}, {})), {:class => style, :nowrap => 'nowrap'})
      tds << content_tag(:div, link_to(tab.name, {}, {:class => 'nav-tab'}), {:class => style, :nowrap => 'nowrap'})
    end
    tds.html_safe
  end

  def navigation_menus
    lis = ''
    menus = Sys::Menu.where("recursion_code like '%#{Sys::Menu.current_menu.recursion_code[0, 3]}%'")
    menus.each do |mm|
      #移除tab页对应的菜单
      next if mm.parent_code.blank?
      lis<<content_tag(:div, mm.name || '')
    end
    lis.html_safe
  end

end
