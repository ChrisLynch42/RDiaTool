require 'i_database_difference'
module RDiaTool
  module Database

    class RailsModelDifference
      include IDatabaseDifference
      @root=false

      attr_reader :options


      def initialize(dia_xml, options)
        @options=options
        initialize_database_difference(dia_xml)
      end

      def root?
        return @root
      end

      private


    end
  end
end
