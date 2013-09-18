require 'active_record'
require 'rails_model_template'
require 'i_database_difference'

module RDiaTool
  module Database

    class TemplateController
      attr_reader :template, :dia_xml, :template_instance, :database_difference, :target_directory, :options
      attr_accessor :database_configuration

      def initialize(dia_xml,template,target_directory,options)
        @template=template
        @dia_xml=dia_xml
        @target_directory=target_directory
        @options=options
#        unless database_configuration.nil? || database_configuration.kind_of?(Hash)
#          raise Exception.new("database configuration is not a hash")
#        end
      end


      def connect
        unless FileTest.exist?(@database_configuration['database'])
          raise Exception.new("Database " + @database_configuration['database'] + " does not exist.")
        end        
        ActiveRecord::Base.establish_connection(@database_configuration)
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
