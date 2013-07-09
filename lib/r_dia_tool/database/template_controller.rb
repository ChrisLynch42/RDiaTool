require 'active_record'
require 'rails_model_template'
require 'database_difference'

module RDiaTool
  module Database

    class TemplateController
      attr_reader :template, :dia_xml, :database_configuration, :template_instance, :database_difference

      def initialize(dia_xml,template,database_configuration)
        @template=template
        @dia_xml=dia_xml
        @database_configuration=database_configuration
        unless database_configuration.nil? || database_configuration.kind_of?(Hash)
          raise Exception.new("database configuration is not a hash")
        end
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
        class_string = "RDiaTool::Database::"+ template + "Template"
        class_constant = class_string.constantize
        @template_instance = class_constant.new()
        !@template_instance.nil?
      end


      def analyze
        connect()
        @database_difference = DatabaseDifference.new(@dia_xml)
      end

    end
  end
end
