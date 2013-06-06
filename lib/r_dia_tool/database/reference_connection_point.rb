require 'dia_connection_point'

module RDiaTool
  module Database
    class DatabaseConnectionPoint
      @translate_hash = Hash.new()
      
      def initialize() 
        13..100.each{ | val |
          row = (val - 13)
          if row > 0
            row = row / 2
          else
            row = 1
          end
          @translate_hash[val]=row;
          @translate_hash[val.to_s]=row;

        }
      end



      def connection_to_column_order(connection_point)
        @translate_hash[connection_point]
      end
    end
  end
end
