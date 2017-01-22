class ModuleGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  attr_reader :module_name, :module_real_name, :module_path


  def initialize(*args)
    super
    @module_name = file_name.underscore
    @module_real_name = module_name.split("_").last
    @module_path = "#{Rails.application.config.fwk.module_folder || 'modules'}/#{module_name}"
  end

  # When a generator is invoked, each public method in the generator
  # is executed sequentially in the order that it is defined.
  def create_initialize_files
    empty_directory "#{module_path}"
    empty_directory "#{module_path}/app"
    empty_directory "#{module_path}/app/controllers"
    empty_directory "#{module_path}/app/helpers"
    empty_directory "#{module_path}/app/models"
    empty_directory "#{module_path}/app/views"
    empty_directory "#{module_path}/config"
    empty_directory "#{module_path}/config/initializers"
    empty_directory "#{module_path}/config/locales"
    empty_directory "#{module_path}/db"
    empty_directory "#{module_path}/db/migrate"
    empty_directory "#{module_path}/lib"
    empty_directory "#{module_path}/lib/#{module_real_name}"

    copy_file 'init_.rb', "#{module_path}/initializers/init_#{module_real_name}.rb" #启用各模块必须的文件
    copy_file 'routes.rb', "#{module_path}/config/routes.rb"
    copy_file 'en.yml', "#{module_path}/config/locales/en.yml"
    copy_file 'zh.yml', "#{module_path}/config/locales/zh.yml"
    copy_file 'init_data.rb', "#{module_path}/lib/init_data.rb" #配置文件，比如：菜单配置、action配置

  end


end
