require 'nokogiri'
require 'dia_parser'
require 'column_parser'
require 'i_table'
require 'table_logical_type_enum'

module RDiaLib
  module Database
    module ITableParser
      include ITable

      def set_up() 
        self.columns = Hash.new()
        self.columns_in_order = Array.new()
        self.references=Hash.new()
        self.type = TableLogicalTypeEnum::STANDARD
      end 


      def parse(target_node)
        if defined? super
          super(target_node)
        end
        set_up()
        set_basics(target_node)
        self.name = get_dia_string(target_node,'name')
        columns_node = target_node.xpath("./dia:attribute[@name='attributes']/dia:composite[@type='table_attribute']")
        if !columns_node.nil?
          columns_node.each { | column_node | 
            columnParser = ColumnParser.new()
            columnParser.parse(column_node)
            self.columns[columnParser.name]=columnParser 
            self.columns_in_order[self.columns_in_order.length]=columnParser 
          }
        end

      end

    end
  end
end
