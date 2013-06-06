require 'nokogiri'
require 'reference_connection_point'

module RDiaTool
  module Database
    module IReferenceParser

      attr_accessor :start_point, :end_point, :xpath_query


      def set_up() 
        self.start_point = ReferenceConnectionPoint.new()
        self.end_point = ReferenceConnectionPoint.new()
        self.xpath_query="./dia:connections/dia:connection"
      end

      def parse(target_node)
        if defined? super
          super(target_node)
        end
        set_up()
        found_nodes = target_node.xpath(xpath_query)
        if !found_nodes.nil?
          found_nodes.each { | side |
            if !side.nil?
              if side['handle'] == '0'
                set_values(self.start_point,side)
              else 
                set_values(self.end_point,side)
              end
            end
          }
        end
      end

      private

      def set_values(target, side) 
        target.handle=side['handle']
        target.target_object_id=side['to']
        target.connection=side['connection']
      end

    end
  end
end
