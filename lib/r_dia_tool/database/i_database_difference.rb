require 'database_object_factory'
require 'database_change'

module RDiaTool
  module Database

    module IDatabaseDifference
      attr_reader :change, :database, :dia_xml, :create


      def initialize_database_difference(dia_xml)
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
          compare_tables(database_tables)
        end

        def compare_tables(database_tables)
          @database.tables_by_name.each { | table_name, table_object |
            if database_tables.include?(table_name)
              @change[table_name]=DatabaseChange.new()
              compare_columns(table_object,table_name)

            else
              @create[table_name]=DatabaseChange.new()
              @create[table_name].add=table_object.columns
            end
          }
        end

        def compare_columns(table_design, table_name)
          database_table_columns = ActiveRecord::Base.connection.columns(table_name)
          database_table_columns.each { | column|
            if table_design.columns.include?(column.name)
              if column.type.to_s().upcase().strip() == table_design.columns[column.name].data_type.upcase().strip()
               # 'do nothing'
              else                
                @change[table_name].modify[column.name]=table_design.columns[column.name]
              end
            else
              remove_column = ColumnParser.new()
              remove_column.name = column.name
              remove_column.data_type = column.type.to_s
              @change[table_name].remove[column.name]=remove_column
            end            
          }
          table_design.columns.each { | column_name, column |
            unless database_table_columns.index{| column | column.name.upcase() == column_name.upcase() }
              @change[table_name].add[column.name]=table_design.columns[column.name]
            end
          }
        end

    end
  end
end
