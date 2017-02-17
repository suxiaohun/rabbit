class Sys::Function < ApplicationRecord

  def self.test
    a = ActiveRecord::Base.connection.execute("select queryChildrenAreaInfo(13)")
  end
end
