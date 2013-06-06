require 'nokogiri'
require 'dia_parser'

module RDiaTool
  module Database
    class ColumnParser < DiaParser

      attr_accessor :name, :data_type, :primary_key, :nullable, :unique, :comment


      def parse(target_node)
        if defined? super
          super(target_node)
        end
        self.name = get_dia_string(target_node,'name')

      end

    end
  end
end
