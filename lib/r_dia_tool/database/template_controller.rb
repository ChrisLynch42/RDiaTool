require 'active_record'
require 'rails_master_slave_template'
require 'rails_model_template'
require 'rails_model_difference'
require 'i_database_difference'

module RDiaTool
  module Database

    class TemplateController
      attr_reader :model_template, :view_template, :model_difference, :dia_xml, :template_instance, :database_difference, :target_directory, :options
      attr_accessor :database_configuration

      def initialize(dia_xml,options)
        @model_template=options[:model] + 'ModelTemplate'
        @model_difference=options[:model] + 'ModelDifference'
        unless options[:template].nil?
          @view_template=options[:model] + options[:template] + 'Template'
        end
        @dia_xml=dia_xml
        @options=options
        unless @options.nil? || @options.kind_of?(Hash)
          raise Exception.new("Options is not a hash")
        end
        if @options[:rails_dir]
          config_file = @options[:rails_dir]
          config_file = config_file + '/config/database.yml'          
          @database_configuration = YAML.load(File.read(config_file))
        else
          if @options[:database_configuration]
            config_file = @options[:database_configuration]
            @database_configuration = YAML.load(File.read(config_file))
          end          
        end
#        unless database_configuration.nil? || database_configuration.kind_of?(Hash)
#          raise Exception.new("database configuration is not a hash")
#        end
      end


      def connect
        if @database_configuration.nil?
          raise Exception.new("Database configuration is nil.")
        end                
        if @database_configuration['development']
          config = @database_configuration['development']
        else
          config = @database_configuration
        end
        unless config['database'][0] == '/'
          config['database']=@options[:rails_dir] + '/' + config['database']
        end        
        unless FileTest.exist?(config['database'])
          raise Exception.new("Database " + config['database'] + " does not exist.")
        else

        end        
        ActiveRecord::Base.establish_connection(config)
        ActiveRecord::Base.connection.tables
        unless ActiveRecord::Base.connected?
          raise Exception.new("Database Connection failed!")
        end        
      end


      def database_connected?
        ActiveRecord::Base.connected?
      end

      def get_template_object(template_name)
        analyze()
        class_string = "RDiaTool::Database::"+ template_name
        class_constant = class_string.constantize
        template_object = class_constant.new(@database_difference,options)
      end      

      def execute_template()
        analyze()
        template_object = get_template_object(@model_template)
        unless template_object.nil?
          template_object.generate()
        end
        unless @view_template.nil?
          template_object = get_template_object(@view_template)
          unless template_object.nil?
            template_object.generate()
          end        
        end
      end


      def analyze
        connect()
        class_string = "RDiaTool::Database::"+ @model_difference
        class_constant = class_string.constantize
        @database_difference = class_constant.new(@dia_xml,@options)
        !@database_difference.nil?
      end

    end
  end
end
