module Gen::MigrationGeneratorExpand
  def self.included(base)
    base.class_eval do
      def create_migration_file
        set_local_assigns!
        validate_file_name!
        migration_template @migration_template, "#{get_module}db/migrate/#{file_name}.rb"
      end
    end
  end
end