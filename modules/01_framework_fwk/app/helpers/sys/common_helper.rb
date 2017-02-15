module Sys::CommonHelper

  def navigation_tabs
    tabs = Sys::Tab.all
    tds = ''
    tabs.each do |tab|
      next unless tab.fav_menu_code == '11'
      style = ''
      if tab.code=='PMS_MANAGE'
        style = 'current-tab'
      else
        style = 'tab'
      end
      # tds << content_tag(:div, content_tag(:div, link_to(tab.name, {:controller => tab.fav_menu_controller, :action => tab.fav_menu_action, :code => tab.code}, {})), {:class => style, :nowrap => 'nowrap'})
      tds << content_tag(:div, link_to(tab.name, {},{:class => style}), {:class => 'tab-div', :nowrap => 'nowrap'})
    end
    tds.html_safe
  end
end
