class CreateSysUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :sys_users do |t|
      t.string :login_name #登录名
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :email
      t.string :phone
      t.string :locked_flag, :limit => 1, :default => 'N' #锁定标志位(Y/N),默认N
      t.integer :locked_time, :default => 600 #锁定时间(单位：秒),默认10分钟，即600s
      t.datetime :locked_until_at #锁定结束日期
      t.datetime :last_login_at #最后一次登录日期
      t.string :status #启用/失效

      t.timestamps
    end
  end
end
