require 'active_record'
require 'yaml'
require 'logger'

module RDiaTool
  module Database

    class TemplateController
      attr_reader :template, :dia_xml_file, :database_configuration

      def initialize(dia_xml_file,template,database_configuration)
        @template=template
        @dia_xml=dia_xml_file
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
        #puts ActiveRecord::Base.methods(true) 
        ActiveRecord::Base.connected?
      end

    end
  end
end
