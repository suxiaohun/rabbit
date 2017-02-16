module MenuFunctionManager
  # class << self
    def map
      @menus ||= {}
      @function_groups ||= {}
      @functions ||= {}
      mapper = Mapper.new
      if block_given?
        yield mapper
      else
        mapper
      end
      @menus.merge! mapper.mapped_menus
    end


    def menus
      @menus
    end

    module_function :map,:menus


    # end

  class Mapper
    def initialize
      @menus ||= {}
      @function_groups ||= {}
      @functions ||= {}
    end

    # def function_group(code, hash)
    #   if code.present? and hash.any?
    #     hash = hash.dup
    #     hash[:code] = code.upcase
    #     handle_function_group(hash)
    #   end
    # end

    #加载配置文件中的菜单数据
    def menu(code, hash = {})
      if code.present? and hash.any?
        hash = hash.dup
        hash[:code] = code
        handle_menu(code, hash)
      end
    end

    #递归处理菜单
    def handle_menu(code, hash, parent_code=nil)
      hash = hash.dup
      tmp ||= {}

      if code.present? && hash && hash.any?
        @menus[code.to_sym] ||= {}
        tmp[:code]= code
        tmp[:name] = hash[:zh][:name] if hash[:zh]
        tmp[:description] = hash[:zh][:description] if hash[:zh]
        tmp[:sequence] = hash[:sequence] ? hash[:sequence] : 10
        #TODO 后期优化下，设置parent_code,暂时以递归优先，解决分开设置menu时，parent_code没有正确加载的问题
        if parent_code.present?
          tmp[:parent_code] = parent_code
        elsif hash[:parent_code].present?
          tmp[:parent_code] = hash[:parent_code]
        end
        #菜单一共有两种：1.实的，有对应的链接；2.虚的，下面继续挂菜单(递归处理)
        if hash[:children] && hash[:children].any?
          hash[:children].each do |key, child|
            handle_menu(key, child, code)
          end
        else
          tmp[:url] = hash[:url] if hash[:url]
        end
        #@menus的key不会重复，但如果配置文件中添加了重复的key，属性会合并，按照加载顺序，以最后加载的为准
        @menus[code.to_sym].merge!(tmp)
      end
    end

    # #递归处理功能组下的子功能
    # def handle_function_group(hash)
    #   hash = hash.dup
    #   code = hash[:code].upcase
    #   @function_groups[code.to_sym] ||= {}
    #   tmp ||= {}
    #   if code.present? and hash and hash.any?
    #     tmp[code.to_sym] ||= {}
    #     tmp[code.to_sym][:zh] = hash[:zh] if hash[:zh]
    #     tmp[code.to_sym][:en] = hash[:en] if hash[:en]
    #     tmp[code.to_sym][:system_flag] = hash[:system_flag] if hash[:system_flag]
    #     tmp[code.to_sym][:po_flag] = hash[:po_flag] if hash[:po_flag]
    #     tmp[code.to_sym][:api_flag] = hash[:api_flag] if hash[:api_flag]
    #     tmp[code.to_sym][:zone_code] = hash[:zone_code].upcase if hash[:zone_code]
    #     tmp[code.to_sym][:controller] = hash[:controller] if hash[:controller]
    #     tmp[code.to_sym][:action] = hash[:action] if hash[:action]
    #     if hash[:children] and hash[:children].any?
    #       @function_groups[code.to_sym][:functions] ||= []
    #       function_keys = ["code", "en", "zh", "default_flag", "public_flag", "login_flag", "system_flag", "api_flag"]
    #       hash[:children].each do |key, child|
    #         child[:code] = key.upcase
    #         child = child.dup
    #         function ||= {}
    #         function[:code] = child[:code] if child[:code]
    #         function[:en] = child[:en] if child[:en]
    #         function[:zh] = child[:zh] if child[:zh]
    #         function[:system_flag] = child[:system_flag] if child[:system_flag]
    #         function[:po_flag] = child[:po_flag] if child[:po_flag]
    #         function[:default_flag] = child[:default_flag] if child[:default_flag]
    #         function[:login_flag] = child[:login_flag] if child[:login_flag]
    #         function[:public_flag] = child[:public_flag] if child[:public_flag]
    #         @function_groups[code.to_sym][:functions].delete_if { |i| i[:code].to_s.eql?(child[:code].to_s) }
    #         @function_groups[code.to_sym][:functions] << function
    #
    #         #添加权限控制
    #         child.keys.each do |k|
    #           unless function_keys.include?(k.to_s)
    #             permission_hash = {k.to_s => child[k.to_s]}
    #             if @functions.keys.include?(child[:code].to_sym)
    #               exists_permissions = @functions[child[:code].to_sym][:permissions]
    #               permissions = permission_hash.dup
    #               exists_permissions.each do |controller, actions|
    #                 if (permission_hash[controller])
    #                   exists_permissions[controller] += permission_hash[controller]
    #                   exists_permissions[controller].uniq!
    #                   permissions.delete(controller)
    #                 end
    #               end
    #               exists_permissions.merge!(permissions)
    #             else
    #               @functions.merge!({child[:code].to_sym => {:permissions => permission_hash}})
    #             end
    #           end
    #         end
    #
    #         @function_groups[code.to_sym].merge!(tmp[code.to_sym])
    #         #handle_function_group(child)
    #       end
    #     else
    #       @function_groups[code.to_sym].merge!(tmp[code.to_sym])
    #     end
    #   end
    # end
    #
    #
    # #处理权限
    # def function(name, hash, options={})
    #   name = name.upcase
    #   @functions ||= {}
    #   if @functions.keys.include?(name.to_sym)
    #     exists_permissions = @functions[name.to_sym][:permissions]
    #     permissions = hash.dup
    #     exists_permissions.each do |controller, actions|
    #       if (hash[controller])
    #         exists_permissions[controller] += hash[controller]
    #         exists_permissions[controller].uniq!
    #         permissions.delete(controller)
    #       end
    #     end
    #     exists_permissions.merge!(permissions)
    #   else
    #     @functions.merge!({name.to_sym => {:permissions => hash, :options => options}})
    #   end
    # end

    def mapped_menus
      @menus
    end

    # def mapped_function_groups
    #   @function_groups
    # end
    #
    # def mapped_functions
    #   @functions
    # end

  end


end