module RDiaTool
  module Database
    class DatabaseObject
      include RDiaTool::Database::TypeEnum
      
      attr_reader :tables_by_name, :tables_by_id, :references


      def initialize(tables_by_name,tables_by_id,references)
        @tables_by_name=tables_by_name
        @tables_by_id=tables_by_id
        @references=references
        set_reference_names()
      end


      def set_reference_names
        @references.each do | key, reference |
          reference.start_point.table_name=get_point_table_name(reference.start_point)
          reference.start_point.column_name=get_point_column_name(reference.start_point)
          reference.end_point.table_name=get_point_table_name(reference.end_point)
          reference.end_point.column_name=get_point_column_name(reference.end_point)
        end
      end

      def get_point_table_name(point)
        table_name = nil
        unless point.nil?          
          if @tables_by_id[point.target_object_id]
            table_name = @tables_by_id[point.target_object_id].name
          end
        end
        table_name
      end

      def get_point_column_name(point)
        column_name = nil
        unless point.nil?          
          if @tables_by_id[point.target_object_id]
            table = @tables_by_id[point.target_object_id]
            column_name = table.columns_in_order[point.column_order - 1].name
          end
        end
        column_name
      end      
    end
  end
end
