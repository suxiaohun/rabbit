#encoding: utf-8
MenuFunctionManager.map do |map|
  map.menu :base_info,{
      :zh=>{:name=>'基础信息',:description=>'基础信息'},
      :children=>{
          :organize_manage=>{
              :zh => {:name => '组织管理', :description => '组织管理'},
              :sequence => 10,
              :zone_code => 'base_info',
              :controller => '/companies',
              :action => 'index',
          },
          :property_info=>{
              :zh => {:name => '建筑信息', :description => '建筑信息'},
              :sequence => 20,
              :zone_code => 'base_info',
              :controller => '/properties',
              :action => 'index',
              :children=>{
                  :property_type=>{
                      :zh => {:name => '建筑类型', :description => '建筑类型'},
                      :sequence => 10,
                      :zone_code=> 'BASE_INFO',
                      :controller => 'mdm/companies',
                      :action => 'index',
                  }
              }
          },
      }
  }
  map.menu :bi_company, {
      :zh => {:name => '公司', :description => '公司'},
      :sequence => 10,
      :parent_code => :organize_manage,
      :zone_code=> 'BASE_INFO',
      :controller => 'mdm/companies',
      :action => 'index',
  }


  map.function :bi_company,{
    :bi_company_show=>{
        :zh=>{:name=>'公司-查看',:description=>'公司-查看'},
        'mdm/companies'=>['index','show']
    },
    :bi_company_new=>{
        :zh=>{:name=>'公司-新建',:description=>'公司-新建'},
        'mdm/companies'=>['new','create']
    },
    :bi_company_edit=>{
        :zh=>{:name=>'公司-修改',:description=>'公司-修改'},
        'mdm/companies'=>['edit','update']
    }
  }

  map.menu :bi_project, {
      :zh => {:name => '项目', :description => '项目'},
      :sequence => 10,
      :parent_code => :organize_manage,
      :zone_code=> 'BASE_INFO',
      :controller => 'mdm/companies',
      :action => 'index',
  }


  map.function :bi_project,{
      :bi_project_show=>{
          :zh=>{:name=>'项目-查看',:description=>'项目-查看'},
          'mdm/projects'=>['index','show']
      },
      :bi_project_new=>{
          :zh=>{:name=>'项目-新建',:description=>'项目-新建'},
          'mdm/projects'=>['new','create']
      },
      :bi_project_edit=>{
          :zh=>{:name=>'项目-修改',:description=>'项目-修改'},
          'mdm/projects'=>['edit','update']
      }
  }
  map.function :property_type,{
      :property_type_show=>{
          :zh=>{:name=>'建筑类型-查看',:description=>'建筑类型-查看'},
          'mdm/property_types'=>['index','show']
      },
      :property_type_new=>{
          :zh=>{:name=>'建筑类型-新建',:description=>'建筑类型-新建'},
          'mdm/property_types'=>['new','create']
      },
      :property_type_edit=>{
          :zh=>{:name=>'建筑类型-修改',:description=>'建筑类型-修改'},
          'mdm/property_types'=>['edit','update']
      }
  }


end