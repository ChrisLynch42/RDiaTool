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
          compare_tables(database_tables)
        end

        def compare_tables(database_tables)
          @database.tables_by_name.each { | table_name, table_object |
            if database_tables.include?(table_name)
              puts 'check'
              puts table_name
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
            print column.type
            puts column.name
            if table_design.columns.include?(column.name)
                print column.type.upcase()
                print '='
                puts table_design.columns[column.name].data_type.upcase()
                puts column.type.to_s().upcase().strip().eql?(table_design.columns[column.name].data_type.upcase().strip())
              if column.type.to_s().upcase().strip() == table_design.columns[column.name].data_type.upcase().strip()
                puts 'do nothing'
              else                
                puts 'change column ' + column.name
                @change[table_name].modify[column.name]=table_design.columns[column.name]
              end
            else
              puts 'remove column ' + column.name
              @change[table_name].remove[column.name]=table_design.columns[column.name]
            end            
          }
          table_design.columns.each { | column_name, column |
            unless database_table_columns.index{| column | column.name.upcase() == column_name.upcase() }
              puts 'add column ' + column_name
              @change[table_name].add[column.name]=table_design.columns[column.name]
            end
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
