#encoding: utf-8
MenuFunctionManager.map do |map|

  map.menu :home_page, {
      :zh => {:name => '首页', :description => '首页'},
      :children => {
          :home_page_sub => {
              :zh => {:name => '首页', :description => '首页'},
              :sequence => 10,
              :zone_code=> 'home_page',
              :controller=> '/common',
              :action=> 'index',
          },
          :login_reocord => {
              :zh => {:name => '登录历史', :description => '登录历史'},
              :sequence => 20,
              :zone_code=> 'home_page',
              :controller=> '/common',
              :action=> 'login_records',
          },

      }
  }



end

