class Sys::Menu < ApplicationRecord




  def self.current_menu_code
    @current_menu_code
  end


  def self.current_menu_code=(code)
    @current_menu_code = code
  end
end
