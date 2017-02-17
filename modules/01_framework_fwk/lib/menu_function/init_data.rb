#encoding: utf-8
MenuFunctionManager.map do |map|

  map.menu :mm_manage, {
      :zh => {:name => '物资管理', :description => '物资管理'},
      :children => {
          :mm_basic_info => {
              :zh => {:name => '基础资料', :description => '基础资料'},
              :sequence => 10,
              :children => {
                  :mm_material_type => {
                      :zh => {:name => '物料类别', :description => '物料类别'},
                      :sequence => 10,
                      :zone_code=> 'MM_MANAGE',
                      :controller => '/mm_material_types',
                      :action => 'index'
                  },
                  :mm_material_record => {
                      :zh => {:name => '物料档案', :description => '物料档案'},
                      :sequence => 20,
                      :zone_code=> 'MM_MANAGE',
                      :controller => '/mm_materials',
                      :action => 'index',
                  }
              }
          },
          :mm_purchase_manage => {
              :zh => {:name => '采购管理', :description => '采购管理'},
              :sequence => 20,
          },
          :mm_store_manage => {
              :sequence => 30,
              :zh => {:name => '库存管理', :description => '库存管理'},
          },
      }
  }

  map.menu :mm_quotation, {
      :zh => {:name => '采购报价单', :description => '采购报价单'},
      :sequence => 10,
      :parent_code => :mm_purchase_manage,
      :zone_code=> 'MM_MANAGE',
      :controller => '/mm_quotations',
      :action => 'index',
  }









end

