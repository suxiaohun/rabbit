module Fwk
  class Railtie < Rails::Railtie
    #配置框架
    config.before_configuration do
      # 配置
      config.fwk = Fwk::Config.instance
    end


    # 扩展rails的生成器generators
    # generators do
    #
    #   #扩展Rails::Generators::NamedBase
    #   Rails::Generators::NamedBase.send(:include, Gen::GeneratorExpand)
    #
    #   #扩展Erb::Generators::ScaffoldGenerator，解决设置--module= xx 以在app/view/xx空文件夹
    #   require 'rails/generators/erb/scaffold/scaffold_generator'
    #   Erb::Generators::ScaffoldGenerator.send(:include, Gen::ScaffoldGeneratorExpand)
    #
    #
    #   require 'rails/generators/active_record/migration/migration_generator'
    #   ActiveRecord::Generators::MigrationGenerator.send(:include, Gen::MigrationGeneratorExpand)
    #
    #
    # end

  end
end