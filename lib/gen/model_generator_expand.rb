module Gen::ModelGeneratorExpand
  def self.included(base)
    base.class_eval do
      class_option :migration, type: :boolean, default: true
      class_option :timestamps, type: :boolean, default: true

      #对于scaffold model两个生成指令来说，会默认添加参数migration=true
      #在重写方法之前，也要重写class_option,且赋默认值true
      #但最新版本的文件已经修正了路径取自 config配置的路径（看情况再说）

      def create_migration_file
        return unless options[:migration] && options[:parent].nil?
        attributes.each { |a| a.attr_options.delete(:index) if a.reference? && !a.has_index? } if options[:indexes] == false
        migration_template '../../migration/templates/create_table_migration.rb', "#{get_module}db/migrate/create_#{table_name}.rb"
      end

    end
  end
end