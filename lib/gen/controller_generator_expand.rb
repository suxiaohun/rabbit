module Gen::ControllerGeneratorExpand
  def self.included(base)
    base.class_eval do
      #扩展生成视图的文件夹
      def copy_view_files
        base_path = File.join("#{get_module}app/views", class_path, file_name)
        empty_directory base_path

        actions.each do |action|
          @action = action
          formats.each do |format|
            @path = File.join(base_path, filename_with_extensions(action, format))
            template filename_with_extensions(:view, format), @path
          end
        end
      end
    end
  end
end
