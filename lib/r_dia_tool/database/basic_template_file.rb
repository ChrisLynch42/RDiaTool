class BasicTemplateFile
  attr_accessor :target_directory, :target_file_name, :source_file_name


  def initialize(target_dir=nil,target_file=nil,source_file=nil)
    self.target_directory=target_dir
    self.target_file_name=target_file
    if !source_file.nil?
      self.source_file_name=source_file
    else
      self.source_file_name=target_file
    end
  end

  def set_file_name(file_name)
    self.target_file_name=file_name
    self.source_file_name=file_name
  end

end
