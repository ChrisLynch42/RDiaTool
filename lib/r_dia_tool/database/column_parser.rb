require 'nokogiri'
require 'dia_parser'
require 'i_column'

module RDiaTool
  module Database
    class ColumnParser < DiaParser
      include IColumn

      def parse(target_node)
        if defined? super
          super(target_node)
        end
        self.name = get_dia_string(target_node,'name')
        self.data_type = get_dia_string(target_node,'type')
        self.comment = get_dia_string(target_node,'comment')
        self.primary_key = get_dia_boolean(target_node,'primary_key')
        self.nullable = get_dia_boolean(target_node,'nullable')
        self.unique = get_dia_boolean(target_node,'unique')
        self.references=Hash.new()

      end

    end
  end
end
