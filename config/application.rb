require_relative 'boot'

require 'rails/all'

# 加载框架配置所需文件
require File.expand_path('../../lib/fwk/config', __FILE__)
require File.expand_path('../../lib/fwk/railtie', __FILE__)
# 加载框架配置
Fwk::Config.instance.modules.each do |m|
  module_path = Fwk::Config.instance.module_path(m)
  railtie_path = "#{module_path}/lib/#{m}/railtie.rb" # 加载各模块配置
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


    # 配置加载module模块
    config.fwk.modules.each do |module_name|
      config.paths.keys.each do |key|
        next unless config.paths[key].to_ary.is_a?(Array)
        file_path ="#{config.fwk.module_folder}/#{config.fwk.module_mapping[module_name]}/#{key}"

        real_file_path = "#{config.root}/#{file_path}"
        if File.exist?(real_file_path)
          #TODO 这一段暂时搁置，后边看看是如何执行的？
          if key.eql?('config/database')
            config.paths[key].to_a[0] = file_path
          else
            #系统提供的方法，添加目录
            config.paths[key].unshift(file_path)
          end
        end

      end

    end


    #自动加载lib目录下的文件
    # config.autoload_paths << Rails.root.join('lib')

    # auto load class in lib and module lib
    config.autoload_paths += config.paths['lib'].expanded

    #generator不生成css与js
    config.generators do |g|
      g.orm :active_record
      g.template_engine :erb
      g.test_framework false
      g.stylesheets false
      g.javascripts false
    end

  end
end
