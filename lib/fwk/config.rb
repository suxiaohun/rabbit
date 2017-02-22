require 'singleton'
module Fwk
  class Config
    include Singleton

    attr_accessor :rails_root, :modules, :module_mapping, :module_folder, :framework_modules, :module_dependencies, :languages, :javascript, :css, :jscss
    attr_accessor :mail_receive_method, :mail_receive_interval, :mail_receive_imap, :mail_receive_pop, :mail_send_from, :production_flag

    def initialize
      self.modules = []
      self.module_mapping = {}
      self.module_folder = 'modules'
      self.framework_modules = [:fwk, :ast, :mdm, :crm]
      self.module_dependencies = {}
      self.javascript = ActiveSupport::OrderedOptions.new
      self.css = ActiveSupport::OrderedOptions.new
      self.languages = [:zh, :en]
      self.jscss = {}
      self.production_flag = 'N'
      # 加载此文件时,rails的配置还没有开始
      self.rails_root = Rails.root||File.expand_path("../../..", __FILE__)


      load_modules = self.framework_modules
      load_modules = load_modules.collect { |i| i.to_s }.uniq
      # 系统模块
      Dir["#{self.rails_root}/#{self.module_folder}/*"].sort.each { |i|
        if File.directory?(i)
          short_name = File.basename(i).split("_").last
          next unless load_modules.include?(short_name)
          self.module_mapping.merge!({short_name => File.basename(i)})
          self.modules << short_name
        end
      }
      # 对系统模块加载顺序排序
      self.modules.sort! { |a, b| self.module_mapping[a].split("_").first.to_i<=>self.module_mapping[b].split("_").first.to_i }
    end

    def module_path(m)
      "#{self.rails_root}/#{self.module_folder}/#{self.module_mapping[m]}"
    end
  end
end