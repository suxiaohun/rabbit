module Fwk::CustomId

  def self.included(base)
    base.class_eval do
      before_create :setup_custom_id

      private
      def setup_custom_id
        id_column = self.class.columns.detect { |i| pk_attribute? i.name }
        #只有字段【名称为id】，【为主键】，【长度>31】三者完全符合才启用uuid替换默认id
        if id_column&&id_column.name=='id'&&id_column.type.eql?(:string)&&id_column.limit>31
          self.id = Fwk::IdGenerator.instance.generate(self.class.table_name)
        end
      end
    end
  end
end