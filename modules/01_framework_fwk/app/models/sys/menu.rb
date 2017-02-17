class Sys::Menu < ApplicationRecord




  def self.current_menu
    @current_menu
  end


  def self.current_menu=(menu)
    @current_menu = menu
  end
end
