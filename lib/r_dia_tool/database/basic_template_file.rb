class BasicTemplateFile
  attr_accessor :target_directory, :target_file_name, :source_file_name


  def set_file_name(file_name)
    self.target_file_name=file_name
    self.source_file_name=file_name
  end

end
