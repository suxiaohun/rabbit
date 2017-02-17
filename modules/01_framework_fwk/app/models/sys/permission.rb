class Sys::Permission < ApplicationRecord

  scope :get_by_url,->(controller,action){
    joins("left join #{Sys::Function.table_name} sf on sf.code = #{table_name}.function_code").
        joins("left join #{Sys::Menu.table_name} sm on sm.code = sf.menu_code").
        select('sm.*').where("#{table_name}.controller=? and #{table_name}.action = ?",controller,action)
  }
end
