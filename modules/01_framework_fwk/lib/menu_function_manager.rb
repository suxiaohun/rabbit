module MenuAndFunctionManager
  # module_function :map

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
    #合并menus
    new_menus = mapper.mapped_menus
    new_menus.each do |code, menu|
      menu = menu.dup
      if @menus[code.to_sym].present?
        menu.keys.each do |i|
          if @menus[code.to_sym][i.to_sym].is_a?(Array)
            #判断是否重复添加
            menu[i.to_sym].each do |m|
              @menus[code.to_sym][i.to_sym].delete_if { |n| n[:sub_menu_code].to_s.eql?(m[:sub_menu_code].to_s) } if m[:sub_menu_code].present?
              @menus[code.to_sym][i.to_sym].delete_if { |n| n[:sub_function_group_code].to_s.eql?(m[:sub_function_group_code].to_s) } if m[:sub_function_group_code].present?
              @menus[code.to_sym][i.to_sym] << m
            end
          else
            @menus[code.to_sym].merge!({i.to_sym => menu[i.to_sym]})
          end
        end
      else
        @menus.merge!({code.to_sym => menu})
      end
    end if new_menus
    #合并function_groups
    new_function_groups = mapper.mapped_function_groups
    new_function_groups.each do |code, group|
      group = group.dup
      if @function_groups[code.to_sym].present?
        group.keys.each do |i|
          if @function_groups[code.to_sym][i.to_sym].is_a?(Array)
            #判断是否重复添加
            group[i.to_sym].each do |g|
              @function_groups[code.to_sym][i.to_sym].delete_if { |n| n[:code].to_s.eql?(g[:code].to_s) }
              @function_groups[code.to_sym][i.to_sym] << g
            end
          else
            @function_groups[code.to_sym].merge!({i.to_sym => group[i.to_sym]})
          end
        end
      else
        @function_groups.merge!({code.to_sym => group})
      end
    end if new_function_groups
    #合并functions
    added_functions = mapper.mapped_functions||[]
    added_functions.each do |function_code, function|
      if @functions.keys.include?(function_code.to_sym)
        exists_permissions = @functions[function_code.to_sym][:permissions]
        permissions = function[:permissions].dup
        exists_permissions.each do |controller, actions|
          if (function[:permissions][controller])
            exists_permissions[controller] += function[:permissions][controller]
            exists_permissions[controller].uniq!
            permissions.delete(controller)
          end
        end
        exists_permissions.merge!(permissions)
      else
        @functions.merge!({function_code.to_sym => function})
      end
    end
  end

  class Mapper
    def initialize
      @menus ||= {}
      @function_groups ||= {}
      @functions ||= {}
    end

    def function_group(code, hash)
      if code.present? and hash.any?
        hash = hash.dup
        hash[:code] = code.upcase
        handle_function_group(hash)
      end
    end

    def menu(code, hash = {})
      if code.present? and hash.any?
        hash = hash.dup
        hash[:code] = code
        handle_menu(code,hash)
      end
    end

    #递归处理子菜单
    def handle_menu(code,hash)
      hash = hash.dup
      tmp ||= {}

      if code.present? && hash && hash.any?
        tmp[code.to_sym] = {}
        tmp[code.to_sym][:zh] = hash[:zh] if hash[:zh]
        tmp[code.to_sym][:en] = hash[:en] if hash[:en]
        tmp[code.to_sym][:sequence] = hash[:sequence] ? hash[:sequence] : 10


        #菜单一共有两种：1.实的，有对应的链接；2.虚的，下面继续挂菜单(递归处理)
        if hash[:type] && hash[:type] == 'entry'
          if hash[:children] && hash[:children].any?
            hash[:children].each do |key, child|
              handle_menu(key,child)
            end
          end
        else
          tmp[code.to_sym][:url] = hash[:url] if hash[:url]
        end
        @menus[code.to_sym].merge!(tmp)
      end
    end

    #递归处理功能组下的子功能
    def handle_function_group(hash)
      hash = hash.dup
      code = hash[:code].upcase
      @function_groups[code.to_sym] ||= {}
      tmp ||= {}
      if code.present? and hash and hash.any?
        tmp[code.to_sym] ||= {}
        tmp[code.to_sym][:zh] = hash[:zh] if hash[:zh]
        tmp[code.to_sym][:en] = hash[:en] if hash[:en]
        tmp[code.to_sym][:system_flag] = hash[:system_flag] if hash[:system_flag]
        tmp[code.to_sym][:po_flag] = hash[:po_flag] if hash[:po_flag]
        tmp[code.to_sym][:api_flag] = hash[:api_flag] if hash[:api_flag]
        tmp[code.to_sym][:zone_code] = hash[:zone_code].upcase if hash[:zone_code]
        tmp[code.to_sym][:controller] = hash[:controller] if hash[:controller]
        tmp[code.to_sym][:action] = hash[:action] if hash[:action]
        if hash[:children] and hash[:children].any?
          @function_groups[code.to_sym][:functions] ||= []
          function_keys = ["code", "en", "zh", "default_flag", "public_flag", "login_flag", "system_flag", "api_flag"]
          hash[:children].each do |key, child|
            child[:code] = key.upcase
            child = child.dup
            function ||= {}
            function[:code] = child[:code] if child[:code]
            function[:en] = child[:en] if child[:en]
            function[:zh] = child[:zh] if child[:zh]
            function[:system_flag] = child[:system_flag] if child[:system_flag]
            function[:po_flag] = child[:po_flag] if child[:po_flag]
            function[:default_flag] = child[:default_flag] if child[:default_flag]
            function[:login_flag] = child[:login_flag] if child[:login_flag]
            function[:public_flag] = child[:public_flag] if child[:public_flag]
            @function_groups[code.to_sym][:functions].delete_if { |i| i[:code].to_s.eql?(child[:code].to_s) }
            @function_groups[code.to_sym][:functions] << function

            #添加权限控制
            child.keys.each do |k|
              unless function_keys.include?(k.to_s)
                permission_hash = {k.to_s => child[k.to_s]}
                if @functions.keys.include?(child[:code].to_sym)
                  exists_permissions = @functions[child[:code].to_sym][:permissions]
                  permissions = permission_hash.dup
                  exists_permissions.each do |controller, actions|
                    if (permission_hash[controller])
                      exists_permissions[controller] += permission_hash[controller]
                      exists_permissions[controller].uniq!
                      permissions.delete(controller)
                    end
                  end
                  exists_permissions.merge!(permissions)
                else
                  @functions.merge!({child[:code].to_sym => {:permissions => permission_hash}})
                end
              end
            end

            @function_groups[code.to_sym].merge!(tmp[code.to_sym])
            #handle_function_group(child)
          end
        else
          @function_groups[code.to_sym].merge!(tmp[code.to_sym])
        end
      end
    end


    #处理权限
    def function(name, hash, options={})
      name = name.upcase
      @functions ||= {}
      if @functions.keys.include?(name.to_sym)
        exists_permissions = @functions[name.to_sym][:permissions]
        permissions = hash.dup
        exists_permissions.each do |controller, actions|
          if (hash[controller])
            exists_permissions[controller] += hash[controller]
            exists_permissions[controller].uniq!
            permissions.delete(controller)
          end
        end
        exists_permissions.merge!(permissions)
      else
        @functions.merge!({name.to_sym => {:permissions => hash, :options => options}})
      end
    end

    def mapped_menus
      @menus
    end

    def mapped_function_groups
      @function_groups
    end

    def mapped_functions
      @functions
    end

  end


end