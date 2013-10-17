require 'i_database_difference'
module RDiaTool
  module Database

    class RailsModelDifference
      include IDatabaseDifference
      @root=false
      IgnoreColumns = [ 'created_at', 'updated_at']
      attr_reader :options

      public
      def initialize(dia_xml, options)
        @dia_xml=dia_xml
        @translation_hash = { 'varchar' => 'string', 'varchar2' => 'string' }
        @options=options

        set_database()
        set_database_tables()
        compare_tables(IgnoreColumns)

        translate_data_types()
        reference_relationships()
      end

      def root?
        return @root
      end

      private

      def reference_relationships
        database.references.each do | key, reference |
          begin
            @database.tables_by_name[reference.start_point.table_name].columns[reference.start_point.column_name].references[key]=reference
          rescue => error           
            addendum =  "-------------------------\nkey=" + key + "\n"
            addendum = addendum +  "reference.start_point.table_name=" + reference.start_point.table_name + "\n"
            addendum = addendum +  "reference.start_point.target_object_id=" +  reference.start_point.target_object_id + "\n"
            addendum =  addendum +  "-------------------------\n"
            error.message = error.message + addendum
            throw error            
          end
        end
      end      

    end
  end
end
