module RDiaTool
  module Database
    class DatabaseObject
      include RDiaTool::Database::TypeEnum
      
      attr_reader :tables_by_name, :tables_by_id, :references_by_origin, :references_by_target


      def initialize(tables_by_name,tables_by_id,references_by_origin,references_by_target)
        @tables_by_name=tables_by_name
        @tables_by_id=tables_by_id
        @references_by_origin=references_by_origin
        @references_by_target=references_by_target
      end



    end
  end
end
