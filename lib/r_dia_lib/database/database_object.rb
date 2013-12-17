module RDiaLib
  module Database
    class DatabaseObject
      include RDiaLib::Database::TypeEnum
      
      attr_reader :tables_by_name, :tables_by_id, :references


      def initialize(tables_by_name,tables_by_id,references)
        @tables_by_name=tables_by_name
        @tables_by_id=tables_by_id
        @references=references
        set_reference_names()
      end


      def set_reference_names
        @references.each do | key, reference |
          if reference.start_point.nil? || reference.start_point.target_object_id.nil? || reference.end_point.nil? || reference.end_point.target_object_id.nil?
            message = "------------------------\n"
            message = message + "A reference is missing an end point.\n"
            message = message + "key object id=#{key}.\n"
            message = message + "reference object id=#{reference.id}.\n"
            unless reference.start_point.nil? || reference.start_point.target_object_id.nil?              
              message = message + "The start point references table #{@tables_by_id[reference.start_point.target_object_id].name}.\n"
            end
            unless reference.end_point.nil? || reference.end_point.target_object_id.nil?
              message = message + "The end point references table #{@tables_by_id[reference.end_point.target_object_id].name}. table object id=#{reference.end_point.target_object_id}\n"
            end
            message = message + "Removing reference from database.\n"
            @references.delete(key)
            raise message
          else
            reference.start_point.table_name=get_point_table_name(reference.start_point)
            reference.start_point.column_name=get_point_column_name(reference.start_point)
            reference.end_point.table_name=get_point_table_name(reference.end_point)
            reference.end_point.column_name=get_point_column_name(reference.end_point)
          end
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
