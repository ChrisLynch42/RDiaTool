require 'database_object_factory'
require 'database_change'

module RDiaLib
  module Database

    module IDatabaseDifference
      attr_reader :database, :dia_xml, :database_tables
      attr_writer :translation_hash

      def change
        if @change.nil?
          @change = Hash.new()
        end
        @change
      end

      def create
        if @create.nil?
          @create = Hash.new()
        end
        @create
      end

      def drop
        if @drop.nil?
          @drop = Hash.new()
        end
        @drop
      end

      def translation_hash
        if @translation_hash.nil?
          @translation_hash = Hash.new()
        end
        @translation_hash
      end


      protected
      def set_database
        database_factory = DatabaseObjectFactory.new(dia_xml)
        @database = database_factory.database()
      end

      def set_database_tables
        @database_tables = ActiveRecord::Base.connection.tables
      end

      def compare_tables(ignore_columns=Array.new())
        create
        change
        drop
        set_database()
        set_database_tables()

        @database.tables_by_name.each { | table_name, table_object |
          if @database_tables.include?(table_name)
            @change[table_name]=DatabaseChange.new()
            compare_columns(table_object,table_name,ignore_columns)

          else
            @create[table_name]=DatabaseChange.new()
            @create[table_name].add=table_object.columns
          end
        }

        @database_tables.each { | table_name |
          if !@database.tables_by_name.include?(table_name) && !table_name.upcase().start_with?('SCHEMA') && !table_name.upcase().start_with?('SQLITE')
            @drop[table_name]=true
          end
        }        
      end

      def compare_columns(table_design, table_name, ignore_columns=Array.new())
        database_table_columns = ActiveRecord::Base.connection.columns(table_name)
        database_table_columns.each { | column|
          if !ignore_columns.include?(column.name)
            if table_design.columns.include?(column.name)
              if column.type.to_s().upcase().strip() == translate_data_type(table_design.columns[column.name].data_type.strip()).upcase()
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
          end   
        }
        table_design.columns.each { | column_name, column |
          unless database_table_columns.index{| column | column.name.upcase() == column_name.upcase() } || ignore_columns.include?(column.name)
            @change[table_name].add[column.name]=table_design.columns[column.name]
          end
        }
      end

      def translate_data_type(data_type)
        holder = data_type.downcase
        if !@translation_hash.nil? && @translation_hash[holder]
          @translation_hash[holder]
        else
          holder
        end
      end

      def translate_data_types
        @create.each do | key, change |
          change.add.each do | key, column |
            column.data_type = translate_data_type(column.data_type)
          end
          change.modify.each do | key, column |
            column.data_type = translate_data_type(column.data_type)
          end
        end
        @change.each do | key, change |
          change.add.each do | key, column |
            column.data_type = translate_data_type(column.data_type)
          end
          change.modify.each do | key, column |
            column.data_type = translate_data_type(column.data_type)
          end
        end
      end      


    end
  end
end
