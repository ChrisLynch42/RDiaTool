require 'nokogiri'
require 'dia_parser'
require 'column_parser'

module RDiaTool
  module Database
    module ITable

      attr_accessor :name, :columns, :columns_in_order, :references


    end
  end
end
