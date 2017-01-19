require 'uuid'
module Fwk
  class IdGenerator
    include Singleton


    def uuid_generator
      @uuid_generator ||= UUID.new
    end

    def generate(table_name)
      [Sys::ObjectCode.code_encrypt(table_name), uuid_encrypt(uuid_generator.generate)].join
    end

    def decimal_to_62(number)
      result = ''
      while number>0
        s = number%62
        if s>35
          s = (s+61).chr
        elsif s>9
          s = (s+55).chr
        end
        result << s.to_s
        number = (number/62).to_i
      end
      result.reverse
    end

    def rjust_decimal_to_62(decimal, length=4)
      result = decimal_to_62(decimal)
      result.rjust(length, '0')
    end

    private
    #获取14位，应该可以满足大部分需要了
    def uuid_encrypt(uuid)
      custom_uuid = uuid[0..(uuid.rindex('-')-1)]
      number = custom_uuid.split('-').reverse.join.hex
      rjust_decimal_to_62(number, 14)
    end

  end

end