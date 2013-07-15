require 'database_object_factory'

module RDiaTool
  module Database

    class DatabaseDifference
      attr_reader :change, :database, :dia_xml


      def initialize(dia_xml)
        @dia_xml=dia_xml
        @database_factory = DatabaseObjectFactory.new(dia_xml)
        @database = @database_factory.database()
        @change = Hash.new()
        compare_database_object_to_database()
      end


      private
        def compare_database_object_to_database
          database_tables = ActiveRecord::Base.connection.tables
          compare_tables(@database.tables_by_name,database_tables)
        end

        def compare_tables(database_object_tables,database_tables)
          puts database_tables
          database_object_tables.each { | table_name, table_object |
            unless database_tables.include?(table_name)
              #puts ActiveRecord::Base.connection.columns(table_name)
              @change[table_name]=DatabaseChange.new()
              compare_columns(database_object_tables[table_name],table_name)
            end
          }
        end

        def compare_columns(table_object,table_name)
          table_object.columns().each { | column_name, column|
            
          }
        end        
    end
  end
end
