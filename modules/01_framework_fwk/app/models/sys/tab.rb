class Sys::Tab < ApplicationRecord


  def self.current_tab
    @current_tab
  end


  def self.current_tab=(tab)
    @current_tab = tab
  end
end
