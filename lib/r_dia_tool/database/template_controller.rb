require 'active_record'
require 'rails_model_template'
require 'i_database_difference'

module RDiaTool
  module Database

    class TemplateController
      attr_reader :template, :dia_xml, :template_instance, :database_difference, :target_directory, :options
      attr_accessor :database_configuration

      def initialize(dia_xml,options)
        @template=options[:template]
        @dia_xml=dia_xml
        @target_directory=options[:target_dir]
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

      def instantiate_template
        analyze()
        class_string = "RDiaTool::Database::"+ template + "Template"
        class_constant = class_string.constantize
        @template_instance = class_constant.new(@database_difference,@target_directory)
        !@template_instance.nil?
      end

      def execute_template()
        if instantiate_template()
          @template_instance.generate()
        end
      end


      def analyze
        connect()
        class_string = "RDiaTool::Database::"+ template + "Difference"
        class_constant = class_string.constantize
        @database_difference = class_constant.new(@dia_xml,@options)
        !@database_difference.nil?
      end

    end
  end
end
