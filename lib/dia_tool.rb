require 'dia_parser'
require 'rubygems'
require 'thor'

class DiaTool < Thor
  desc "model_generate FILE", "Generate code files from a Dia database diagram."
  method_option :database_configuration, :aliases => "-c", :type => :string, :desc => "An ActiveRecord datase configuration in YAML format."
  method_option :rails_dir, :aliases => "-r", :type => :string, :desc => "Root directory of a rails application.  If this option is used it will override the --database_configuration option."
  method_option :template, :aliases => "-t", :type => :string, :required => true, :desc => "This is the template used to generate the source code"
  method_option :target_dir, :aliases => "-d", :type => :string, :required => true, :desc => "This is the directory where you would like the generated code placed."  
  def model_build(dia_database_diagram)
    puts 'finish me'
    puts options[:rails_dir]
  end
end

