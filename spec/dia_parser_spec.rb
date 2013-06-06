require 'spec_helper'
require 'nokogiri'

module RDiaTool
  describe "Dia Parser" do
    the_hash = Hash.new()
    the_node_set = loadTestXML()

    dia_parser = DiaParser.new()

    it "should not be 'nil'" do
      dia_parser.should_not == nil
    end


    string_xml = <<-xml
    <?xml version="1.0" encoding="UTF-8"?>
    <dia:diagram xmlns:dia="http://www.lysator.liu.se/~alla/dia/">
      <root>
      <dia:attribute name="comment">
        <dia:string>#success#</dia:string>
      </dia:attribute
      </root>
    </dia:diagram>
    xml

    string_doc  = Nokogiri::XML(string_xml)
    string_doc = string_doc.xpath('//root')

    it "get_dia_attribute_string should return '#success#' for string_doc nodes" do
      result = dia_parser.get_dia_attribute_string(string_doc,"comment")
      result.should == "#success#"
    end

    it "get_dia_string should return 'success' for string_doc nodes" do
      result = dia_parser.get_dia_string(string_doc,"comment")
      result.should == "success"
    end

    it "get_dia_attribute_enum should return '1'  " do

      input_xml = <<-xml
    <?xml version="1.0" encoding="UTF-8"?>
    <dia:diagram xmlns:dia="http://www.lysator.liu.se/~alla/dia/">
      <root>
        <dia:attribute name="visibility">
          <dia:enum val="1"/>
        </dia:attribute
      </root>
    </dia:diagram>
      xml
      xml_doc  = Nokogiri::XML(input_xml)
      xml_doc = xml_doc.xpath('//root')
      result = dia_parser.get_dia_attribute_enum(xml_doc,"visibility")
      result.should == "1"
    end


    boolean_xml = <<-xml
    <?xml version="1.0" encoding="UTF-8"?>
    <dia:diagram xmlns:dia="http://www.lysator.liu.se/~alla/dia/">
      <root test_attribute="test">
       <dia:attribute name="visible_operations">
        <dia:boolean val="true"/>
      </dia:attribute
      </root>
    </dia:diagram>
    xml

    boolean_doc  = Nokogiri::XML(boolean_xml)
    boolean_doc = boolean_doc.xpath('//root')

    it "get_dia_attribute_boolean should return 'true'  " do
      result = dia_parser.get_dia_attribute_boolean(boolean_doc,"visible_operations")
      result.should == "true"
    end

    it "get_dia_boolean should return true  " do
      result = dia_parser.get_dia_boolean(boolean_doc,"visible_operations")
      result.should == true
    end

  end
end
