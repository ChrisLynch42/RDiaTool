$LOAD_PATH.unshift File.expand_path('lib')
$LOAD_PATH.unshift File.expand_path('lib/r_dia_lib')
$LOAD_PATH.unshift File.expand_path('lib/r_dia_lib/database')

require 'pp'
require 'nokogiri'
require 'r_dia_tool'
require 'dia_parser'
require 'reference_connection_point'
require 'i_reference_parser'
require 'i_column'
require 'column_parser'
require 'i_table'
require 'i_table_parser'
require 'parser_class_factory'
require 'parser_class_factory_spec_helper'
require 'type_enum'
require 'basic_template_file'
require 'i_basic_template'
require 'code_template'
require 'database_object'
require 'database_object_factory'
require 'template_controller'
require 'rails_model_template'
require 'rails_master_slave_template'
require 'i_database_difference'
require 'rails_model_difference'
require 'database_change'
require 'table_logical_type_enum'






def loadTestXML
  f = File.open("./spec/test.dia")
  doc = Nokogiri::XML(f)
  f.close()
  doc
end



