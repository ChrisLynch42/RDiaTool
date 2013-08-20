require 'database_object_factory'

module RDiaTool
  module Database

    class DatabaseDifference
      attr_reader :change, :database, :dia_xml, :create


      def initialize(dia_xml)
        @dia_xml=dia_xml
        @database_factory = DatabaseObjectFactory.new(dia_xml)
        @database = @database_factory.database()
        @change = Hash.new()
        @create = Hash.new()
        compare_database_object_to_database()
      end


      private
        def compare_database_object_to_database
          database_tables = ActiveRecord::Base.connection.tables
          compare_tables(@database.tables_by_name,database_tables)
        end

        def compare_tables(database_object_tables,database_tables)
          database_object_tables.each { | table_name, table_object |
            if database_tables.include?(table_name)
              # compare_columns(database_object_tables[table_name],table_name)
              puts 'check'
              puts ActiveRecord::Base.connection.columns(table_name).nil?
            else
              @create[table_name]=DatabaseChange.new()
              @create[table_name].add=database_object_tables[table_name].columns
            end
          }
        end

        def compare_columns(table_object,table_name)
          
          table_object.columns().each { | column_name, column|
            puts 'xxx'
            
          }
        end

        def add_column(database_change, column_object)
          puts 'add_column'
          unless database_change.nil?            

          end
        end
    end
  end
end
