class Sys::Tab < ApplicationRecord


  def self.current_tab_code
    @current_tab_code
  end


  def self.current_tab_code=(code)
    @current_tab_code = code
  end
end
