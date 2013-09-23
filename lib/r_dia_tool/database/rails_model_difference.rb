require 'i_database_difference'
module RDiaTool
  module Database

    class RailsModelDifference
      include IDatabaseDifference
      @root=false

      attr_reader :options


      def initialize(dia_xml, options)
        @options=options
        if @options[:rails_dir]
          @root=false
        end
        initialize_database_difference(dia_xml)
        reference_relationships()
      end

      def reference_relationships
        database.references_by_origin.each do | key, reference |
          if create[database.tables_by_id[key].name]
            create[database.tables_by_id[key].name].add[reference.start_point.column_name].data_type='Reference'
          end
          if change[database.tables_by_id[key].name]
            if change[database.tables_by_id[key].name].modify[reference.start_point.column_name]
              change[database.tables_by_id[key].name].modify[reference.start_point.column_name].data_type='Reference'
            end
          end          
        end
      end

      def root?
        return @root
      end

    end
  end
end
