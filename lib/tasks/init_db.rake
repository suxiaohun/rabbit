#新增加覆盖原来task的方法,
Rake::TaskManager.class_eval do
  def alias_task(old_name, new_name)
    @tasks[new_name] = @tasks.delete(old_name)
  end
end


#将原db:migrate 重命名为 db:migrate_original
Rake.application.alias_task('db:migrate', 'db:migrate_original')


namespace :db do
  desc '执行module各db/migrate文件夹下的migration(options: VERSION=x, VERBOSE=false,PRODUCT=sr)'
  task :migrate => :environment do
    # main app migrate
    migrate_paths = ['db/migrate']
    Rails.application.paths['db/migrate'].to_a.each do |f|
      migrate_paths << f #执行db/migrate目录下所有文件
    end if Rails.application.paths["db/migrate"].to_a.length > 1
    ActiveRecord::Migrator.migrate(migrate_paths, nil)
  end

end
