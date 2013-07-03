require 'nokogiri'
require 'dia_parser'
require 'column_parser'
require_relative 'i_table_parser'
require 'reference_connection_point'
require 'i_reference_parser'
require 'type_enum'


module RDiaTool
  module Database
    class ParserFactory
      include RDiaTool::Database::TypeEnum
      include RDiaTool::Database

      attr_accessor :parser_parts, :parser_types

      def initialize
        self.parser_parts=Hash.new()
        self.parser_parts['reference'] = 'IReferenceParser'
        self.parser_parts['table'] = 'ITableParser'

        self.parser_types = Hash.new()
        self.parser_types[TABLE]=['table']
        self.parser_types[REFERENCE]=['reference']

      end

      public
      def parser(parser_type)
        return_value=nil
        if !self.parser_types[parser_type].nil?
          return_value = Class.new( RDiaTool::DiaParser )
          add_modules(parser_type,return_value)
        end

        return_value
      end

      private
      def add_modules(parser_type, parser_object)
        if !self.parser_types[parser_type].nil?
          self.parser_types[parser_type].each { | module_type |
            if !self.parser_parts[module_type].nil?
              parser_object.send(:include, ParserFactory.const_get(self.parser_parts[module_type]))
            end
          }
        end
      end

    end
  end
end
