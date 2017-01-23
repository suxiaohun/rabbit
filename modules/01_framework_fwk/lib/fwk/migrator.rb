module Fwk::Migrator
  class Base < ActiveRecord::Migrator
    def migrate

    end

    private
    #在ironmine中的migrator中需要初始化数据，因此不管数据库支不支持ddl_transaction都加入事务处理
    # Wrap the migration in a transaction only if supported by the adapter.
    def ddl_transaction(&block)
        #if Base.connection.supports_ddl_transactions?
          ActiveRecord::Base.transaction { block.call }
        #else
        #  block.call
       #end
    end

  end
  class TableMigrator< Base

  end

end