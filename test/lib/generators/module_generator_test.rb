require 'test_helper'
require 'generators/module/module_generator'

class ModuleGeneratorTest < Rails::Generators::TestCase
  tests ModuleGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
