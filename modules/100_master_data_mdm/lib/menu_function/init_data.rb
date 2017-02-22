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
          }
      }
  }

  map.function :organize_manage,{
    :bi_company=>{
        :zh=>{:name=>'公司',:description=>'公司'},
        'mdm/companies'=>['index']
    }
  }

end