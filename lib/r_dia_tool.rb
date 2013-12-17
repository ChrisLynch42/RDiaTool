require 'dia_parser'
require 'rubygems'
require 'thor'
require 'template_controller'

class RDiaTool < Thor
  
  TEMPLATES = ['MasterSlave']


  desc "model_generate FILE", "Generate code files from a Dia database diagram."
  method_option :rails_dir, :aliases => "-r", :type => :string, :required => true, :desc => "Root directory of a rails application."
  method_option :template, :aliases => "-t", :type => :string, :required => true, :desc => "This is the template used to generate the source code for views and controllers.  Currently only 'MasterSlave' template is available."
  method_option :force_model, :aliases => "-f", :type => :string, :default => false, :lazy_default => true, :desc => "Force update of models whether or not database has changed."
  ####### There is a default method_option called :model which will always be Rails for now.
  def database_generate(dia_database_diagram)
    application_options = Hash.new()
    options.each do | key, value |
      application_options[key.to_sym]=value
    end
    application_options[:model]='Rails'
    has_error=false
    dia_database_diagram = File.expand_path(dia_database_diagram)    
    unless File.exist?(dia_database_diagram)
      say "Dia database diagram does not exist", :red
      has_error=true
    end
    unless options[:rails_dir].nil? || Dir.exist?(options[:rails_dir])
      say "Rails directory does not exist", :red
      has_error=true
    else
      application_options[:rails_dir] = File.expand_path(options[:rails_dir])
    end
    if options[:template].nil?
      say "You must select a template using --template", :red
      has_error=true
    else
      unless TEMPLATES.include?(options[:template])
        say "You have not selected a valid template.  'MasterSlave' is the only valid template.", :red
        has_error=true
      end
    end
    if has_error
     return
    else
      f = nil
      begin
        f = File.open(dia_database_diagram)
        dia_xml = Nokogiri::XML(f)
      rescue
        say "Error reading database diagram", :red
      ensure
        f.close()
      end
      begin
        template_controller = RDiaTool::Database::TemplateController.new(dia_xml,application_options)
        template_controller.execute_template()
        say 'RDiaTool Rails Model completed successfully.', :green
      rescue => error
        say 'Internal RDiaTool Error', :red
        say '-------------------------', :red
        say error.message, :red
        unless error.backtrace.nil?
          error.backtrace.each do | line |
            say line, :red
          end
        end

      end
    end
  end
end

