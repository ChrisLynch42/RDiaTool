require 'nokogiri'
require 'dia_parser'

module RDiaTool
  module Database
    module IColumn

      attr_accessor :name, :data_type, :primary_key, :nullable, :unique, :comment, :foreign_table, :foreign_column


    end
  end
end
