require 'nokogiri'
require 'dia_parser'
require 'column_parser'

module RDiaTool
  module Database
    module ITableParser

      attr_accessor :name, :columns

      def set_up() 
        self.columns = Hash.new()
      end 


      def parse(target_node)
        if defined? super
          super(target_node)
        end
        set_up()
        self.name = get_dia_string(target_node,'name')
        columns_node = target_node.xpath("./dia:attribute[@name='attributes']/dia:composite[@type='table_attribute']")
        if !columns_node.nil?
          columns_node.each { | column_node | 
            columnParser = ColumnParser.new()
            columnParser.parse(column_node)
            self.columns[columnParser.name]=columnParser 
          }
        end

      end

    end
  end
end
