#encoding: utf-8
MenuFunctionManager.map do |map|

  map.menu :wm_manage, {
      :zh => {:name => '物资管理', :description => '物资管理'},
      :children => {
          :wm_basic_info => {
              :zh => {:name => '基础资料', :description => '基础资料'},
              :sequence => 10,
              :children => {
                  :wm_material_type => {
                      :zh => {:name => '物料类别', :description => '物料类别'},
                      :sequence => 10,
                      :url => '/wm_material_types/index'
                  },
                  :wm_material_record => {
                      :zh => {:name => '物料档案', :description => '物料档案'},
                      :sequence => 20,
                      :url => '/wm_materials/index'
                  }
              }
          },
          :wm_purchase_manage => {
              :zh => {:name => '采购管理', :description => '采购管理'},
              :sequence => 20,
          },
          :wm_store_manage => {
              :sequence => 30,
              :zh => {:name => '库存管理', :description => '库存管理'},
          },
      }
  }


end

