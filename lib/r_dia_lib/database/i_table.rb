require 'nokogiri'
require 'dia_parser'
require 'column_parser'

module RDiaLib
  module Database
    module ITable

      attr_accessor :name, :columns, :columns_in_order, :references, :type


    end
  end
end
