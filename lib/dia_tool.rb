require 'dia_parser'
require 'rubygems'
require 'thor'

class DiaTool < Thor
  
  TEMPLATES = ['RailsModel']


  desc "database_generate FILE", "Generate code files from a Dia database diagram."
  method_option :database_configuration, :aliases => "-c", :type => :string, :desc => "An ActiveRecord datase configuration in YAML format."
  method_option :rails_dir, :aliases => "-r", :type => :string, :desc => "Root directory of a rails application.  If this option is used it will override the --database_configuration option."
  method_option :template, :aliases => "-t", :type => :string, :required => true, :desc => "This is the template used to generate the source code.  Currently only 'RailsModel' template is available."
  method_option :target_dir, :aliases => "-d", :type => :string, :required => true, :desc => "This is the directory where you would like the generated code placed."  
  def database_generate(dia_database_diagram)
    has_error=false
    unless dia_database_diagram.nil? || File.exist?(dia_database_diagram)
      puts "Dia database diagram does not exist"
      has_error=true
    else
      dia_database_diagram = File.expand_path(dia_database_diagram)
    end
    unless options[:target_dir].nil? || Dir.exist?(options[:target_dir])
      puts "Target directory does not exist"
      has_error=true
    else
      options[:target_dir] = File.expand_path(options[:target_dir])
    end
    unless options[:rails_dir].nil? || Dir.exist?(options[:rails_dir])
      puts "Rails directory does not exist"
      has_error=true
    else
      options[:rails_dir] = File.expand_path(options[:rails_dir])
    end
    unless options[:database_configuration].nil? || File.exist?(options[:database_configuration])
      puts "Database configuration file does not exist"
      has_error=true
    else
      options[:database_configuration] = File.expand_path(options[:database_configuration])
    end    
    if options[:template].nil?
      puts "You must select a template using --template"      
      has_error=true
    else
      unless TEMPLATES.include?(options[:template])
        puts "You have not selected a valid template.  'RailsModel' is the only valid template."
        has_error=true
      end
    end
    if options[:database_configuration].nil? && options[:rails_dir].nil?
      puts "Either --database_configuration or --rails_dir must be used."
      return
    end
    if has_error
     return
    else
      #instantiate template controller
    end
  end
end

