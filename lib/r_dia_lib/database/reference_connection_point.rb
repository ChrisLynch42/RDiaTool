require 'dia_connection_point'

module RDiaLib
  module Database
    class ReferenceConnectionPoint < DiaConnectionPoint
      attr_accessor :column_name, :table_name
      
      def initialize() 
        @translate_hash = Hash.new()
        (12..200).each{ | val |
          evenVal = val - (val % 2)
          row = (evenVal - 10)
          row = row / 2
          @translate_hash[val]=row;
          @translate_hash[val.to_s]=row;

        }
      end

      def column_order
        connection_to_column_order(@connection)
      end
     
      def connection_to_column_order(connection_point)
        @translate_hash[connection_point]
      end
    end
  end
end
