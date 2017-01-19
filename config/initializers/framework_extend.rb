require "#{Rails.root}/lib/fwk/custom_id"

#扩展ActionRecord::Base,使用自定义的ID
ActiveRecord::Base.send(:include, Fwk::CustomId)