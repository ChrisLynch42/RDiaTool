require 'dia_parser'
require 'rubygems'
require 'thor'

class DiaTool < Thor
  
  TEMPLATES = ['RailsModel']


  desc "model_generate FILE", "Generate code files from a Dia database diagram."
  method_option :rails_dir, :aliases => "-r", :type => :string, :required => true, :desc => "Root directory of a rails application."
  method_option :template, :aliases => "-t", :type => :string, :required => true, :desc => "This is the template used to generate the source code for views and controllers.  Currently only 'MasterSlave' template is available."
  ####### There is a default method_option called :model which will always be Rails for now.
  def database_generate(dia_database_diagram)
    options[:model]='Rails'
    has_error=false
    unless dia_database_diagram.nil? || File.exist?(dia_database_diagram)
      puts "Dia database diagram does not exist"
      has_error=true
    else
      dia_database_diagram = File.expand_path(dia_database_diagram)
    end
    unless options[:rails_dir].nil? || Dir.exist?(options[:rails_dir])
      puts "Rails directory does not exist"
      has_error=true
    else
      options[:rails_dir] = File.expand_path(options[:rails_dir])
    end
    if options[:template].nil?
      puts "You must select a template using --template"      
      has_error=true
    else
      unless TEMPLATES.include?(options[:template])
        puts "You have not selected a valid template.  'MasterSlave' is the only valid template."
        has_error=true
      end
    end
    if has_error
     return
    else
      #instantiate template controller
    end
  end
end

