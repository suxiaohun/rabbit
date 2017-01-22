module Fwk
  class Railtie < Rails::Railtie
    #配置框架
    config.before_configuration do
      # 配置
      config.fwk = Fwk::Config.instance
    end


    # 扩展rails的生成器generators
    generators do

      #扩展Rails::Generators::NamedBase
      Rails::Generators::NamedBase.send(:include, Gen::GeneratorExpand)

      #扩展Erb::Generators::ScaffoldGenerator
      # require 'rails/generators/erb/scaffold/scaffold_generator'
      # Erb::Generators::ScaffoldGenerator.send(:include, Gen::ScaffoldGeneratorExpand)


      #扩展Erb::Generators::ControllerGenerator
      require 'rails/generators/erb/controller/controller_generator'
      Erb::Generators::ControllerGenerator.send(:include, Gen::ControllerGeneratorExpand)


      require 'rails/generators/active_record/migration/migration_generator'
      ActiveRecord::Generators::MigrationGenerator.send(:include, Gen::MigrationGeneratorExpand)


      #扩展ActiveRecord::Generators::ModelGenerator
      require 'rails/generators/active_record/model/model_generator'
      ActiveRecord::Generators::ModelGenerator.send(:include, Gen::ModelGeneratorExpand)

    end

  end
end