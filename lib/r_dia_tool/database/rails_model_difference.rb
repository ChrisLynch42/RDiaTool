require 'i_database_difference'
module RDiaTool
  module Database

    class RailsModelDifference
      include IDatabaseDifference
      @root=false

      attr_reader :options

      public
      def initialize(dia_xml, options)
        @translation_hash = { 'varchar' => 'string', 'varchar2' => 'string' }
        @options=options
        if @options[:rails_dir]
          @root=false
        end
        initialize_database_difference(dia_xml)
        translate_data_types()
        reference_relationships()
      end

      def root?
        return @root
      end

      private
      def reference_relationships
        database.references_by_origin.each do | key, reference |
          @database.tables_by_name[database.tables_by_id[key].name].columns[reference.start_point.column_name].foreign_table=reference.end_point.table_name
          @database.tables_by_name[database.tables_by_id[key].name].columns[reference.start_point.column_name].foreign_column=reference.end_point.column_name
        end
      end

      def translate_data_types
        create.each do | key, change |
          change.add.each do | key, column |
            column.data_type = translate_data_type(column.data_type)
          end
          change.modify.each do | key, column |
            column.data_type = translate_data_type(column.data_type)
          end
        end
        change.each do | key, change |
          change.add.each do | key, column |
            column.data_type = translate_data_type(column.data_type)
          end
          change.modify.each do | key, column |
            column.data_type = translate_data_type(column.data_type)
          end
        end
      end

      def translate_data_type(data_type)
        holder = data_type.downcase
        if @translation_hash[holder]
          @translation_hash[holder]
        else
          holder
        end
      end      

    end
  end
end
