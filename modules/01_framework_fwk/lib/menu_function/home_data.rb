#encoding: utf-8
MenuFunctionManager.map do |map|

  map.menu :home_page, {
      :zh => {:name => '首页', :description => '首页'},
      :children => {
          :todo_task => {
              :zh => {:name => '待办事项', :description => '待办事项'},
              :sequence => 10,
              :zone_code => 'home_page',
              :controller => 'sys/common',
              :action => 'index',
          },
          :login_record => {
              :zh => {:name => '登录历史', :description => '登录历史'},
              :sequence => 20,
              :zone_code => 'home_page',
              :controller => 'sys/common',
              :action => 'login_records',
          },

      }
  }

  map.function :todo_task, {
      :todo_task => {
          :zh => {:name => '待办事项', :description => '待办事项'},
          'sys/common' => ['index']
      },
  }

  map.function :login_record, {
      :login_record => {
          :zh => {:name => '登录历史', :description => '登录历史'},
          'sys/common' => ['login_records']
      }
  }



end

