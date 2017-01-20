module Gen::ModelGeneratorExpand
  def self.included(base)
    base.class_eval do
      def create_migration_file
        return unless options[:migration] && options[:parent].nil?
        attributes.each { |a| a.attr_options.delete(:index) if a.reference? && !a.has_index? } if options[:indexes] == false
        migration_template '../../migration/templates/create_table_migration.rb', "#{get_module}db/migrate/create_#{table_name}.rb"
      end

    end
  end
end