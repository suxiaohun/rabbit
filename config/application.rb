require_relative 'boot'

require 'rails/all'

# 加载框架配置所需文件
require File.expand_path('../../lib/fwk/config', __FILE__)
require File.expand_path('../../lib/fwk/railtie', __FILE__)
# 加载框架配置
Fwk::Config.instance.modules.each do |m|
  module_path = Fwk::Config.instance.module_path(m)
  railtie_path = "#{module_path}/lib/#{m}/railtie.rb"# 加载各模块配置
  if File.exist?(railtie_path)
    require railtie_path
  end
end



# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rabbit
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
