$LOAD_PATH.unshift File.expand_path('lib')
$LOAD_PATH.unshift File.expand_path('lib/r_dia_tool')

require 'nokogiri'
require 'r_dia_tool'
require 'dia_parser'






def loadTestXML
  f = File.open("./spec/test.dia")
  doc = Nokogiri::XML(f)
  f.close()
  doc
end

