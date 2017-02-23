module Sys::CommonHelper

  def navigation_tabs
    tabs = Sys::Tab.all
    tds = ''
    tabs.each do |tab|
      next unless tab.fav_url.present?
      style = ''
      if tab.code == Sys::Tab.current_tab.code
        style = 'tab-div current'
      else
        style = 'tab-div'
      end

      # tds << content_tag(:div, content_tag(:div, link_to(tab.name, {:controller => tab.fav_menu_controller, :action => tab.fav_menu_action, :code => tab.code}, {})), {:class => style, :nowrap => 'nowrap'})
      tds << content_tag(:div, link_to(tab.name, tab.fav_url, {:class => 'nav-tab'}), {:class => style, :nowrap => 'nowrap'})
    end

    tds.html_safe
  end

  def navigation_menus
    cr_code = Sys::Menu.current_menu.recursion_code
    menus = Sys::Menu.where("recursion_code like '#{cr_code[0, 3]}%'").order('recursion_code,sequence')


    lis = generate_menu(menus.first, menus,to_cr_arr(cr_code))
    recursion_code = ''
    # menus.each do |mm|
    #   #移除tab页对应的菜单
    #   next if mm.parent_code.blank?
    #   #菜单需要进行分级处理,递归code如果不相等，则表示菜单级别改变了
    #   if recursion_code != mm.recursion_code
    #     lis<<'<ul>'
    #   end
    #   lis<<content_tag(:div, mm.name || '')
    # end
    script = '
    $(function(){
        init_side_menu();
    });
    '
    (lis+javascript_tag(script)).html_safe
    # lis.html_safe
  end

  def generate_menu(p_menu, menus,cr_codes, lis='')
    # if display
    #   lis<<'<ul style="display:none">'
    # else
    #   lis<<'<ul>'
    # end
    if cr_codes.include? p_menu.recursion_code
      lis<<'<ul>'
    else
      lis<<'<ul style="display:none">'
    end
    # lis<<'<ul>'
    menus.select { |x| x.parent_code==p_menu.code }.each do |menu|
      count = menus.select { |k| k.parent_code==menu.code }.count
      if count>0
        lis<<"<li><a class=\"inactive\" href=\"javascript:void(0);\">#{menu.name}</a>"
        generate_menu(menu, menus, cr_codes,lis)
      else
        #高亮当前url对应的菜单
        class_name = ''
        if Sys::Menu.current_menu.code == menu.code
          class_name = 'current_menu_li'
        end
        lis<<'<li>' + link_to(menu.name, {:controller => menu.controller, :action => menu.action}, {:class => class_name})
      end
      lis<<'</li>'
    end
    lis<<'</ul>'
  end


  def to_cr_arr(str)
    arr = []
    (str.length/3).times do |i|
      arr<<str[0,i*3+3]
    end
    arr
  end

end
