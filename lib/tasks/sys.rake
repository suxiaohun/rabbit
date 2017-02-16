namespace :sys do
  desc 'init menus,functions,permissions'
  task init_menu: :environment do
    CLEAR = "\e[0m"
    BOLD = "\e[1m"
    RED = "\e[31m"
    GREEN = "\e[32m"
    YELLOW = "\e[33m"
    BLUE = "\e[34m"

    puts "#{BOLD}#{BLUE}|----start init menus----|#{CLEAR}"
    puts "#{BOLD}#{RED}  delete all old menus#{CLEAR}"

    #暂时只支持mysql、sqlite3，后期慢慢添加
    _db_adapter = ActiveRecord::Base.connection.adapter_name.downcase
    if _db_adapter.include? 'mysql'
      ActiveRecord::Base.connection.execute("TRUNCATE #{Sys::Menu.table_name}")
    else
      Sys::Menu.destroy_all
    end


    begin
      rails_config = Rails.application.config
      rails_config.fwk.modules.each do |module_name|
        next if module_name == 'ast'
        Dir.foreach(File.join(Rails.root, rails_config.fwk.module_folder, rails_config.fwk.module_mapping[module_name], 'lib', 'menu_function')) do |file|
          next if file == '.' or file == '..'
          data_file_path = File.join(Rails.root, rails_config.fwk.module_folder, rails_config.fwk.module_mapping[module_name], 'lib', 'menu_function', file)
          if data_file_path&&File::exists?(data_file_path)
            require data_file_path
          end
        end
      end
    end

    menus = MenuFunctionManager.menus
    menus ||= {}

    menus.each do |k, v|
      Sys::Menu.create!(v)
      puts "  #{BOLD}#{GREEN}success create menu => #{v[:code]}#{CLEAR}"
    end
    puts "#{BOLD}#{BLUE}|----init menus done----|#{CLEAR}"


  end

end
