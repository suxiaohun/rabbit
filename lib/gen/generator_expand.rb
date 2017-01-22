module Gen::GeneratorExpand
  def self.included(base)
    base.class_eval do
      class_option :module, :type => :string, :default => '', :desc => 'tell which module to place the files'

      #重载模板方法
      no_tasks do
        def template(source, *args, &block)
          #migration并不是用templates方法创建模板，加上get_module也没用
          unless source.eql?('migration.rb')
            args.each_with_index do |arg, index|
              args[index] = "#{get_module}#{arg}"
            end
          end
          inside_template do
            super
          end
        end
      end

      #获取传递过来的参数判断是否含有module
      def get_module
        return '' if options[:module].blank?
        mdl = Rails.application.config.fwk.module_mapping[options[:module]]
        raise "不存在#{options[:module]}模块，请先创建#{options[:module]}模块，或仔细核对module参数" unless mdl
        "#{Rails.application.config.fwk.module_folder||'modules'}/#{mdl}/"
      end
    end
  end
end
