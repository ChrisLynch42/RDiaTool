require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    class TestReferenceParser
      include IReferenceParser
    end

    describe "IReferenceParser" do

      before(:each) do 
        @reference_parser = TestReferenceParser.new()

        input_xml = <<-xml
          <?xml version="1.0" encoding="UTF-8"?>
            <dia:diagram xmlns:dia="http://www.lysator.liu.se/~alla/dia/">
            <root>
              <dia:object type="Database - Reference" version="0" id="O2">
                <dia:attribute name="obj_pos">
                  <dia:point val="29.36,13.4"/>
                </dia:attribute>
                <dia:attribute name="obj_bb">
                  <dia:rectangle val="29.36,12.75;37.1,15.3"/>
                </dia:attribute>
                <dia:attribute name="meta">
                  <dia:composite type="dict"/>
                </dia:attribute>
                <dia:attribute name="orth_points">
                  <dia:point val="29.36,13.4"/>
                  <dia:point val="35.3375,13.4"/>
                  <dia:point val="35.3375,15.3"/>
                  <dia:point val="37.1,15.3"/>
                </dia:attribute>
                <dia:attribute name="orth_orient">
                  <dia:enum val="0"/>
                  <dia:enum val="1"/>
                  <dia:enum val="0"/>
                </dia:attribute>
                <dia:attribute name="orth_autoroute">
                  <dia:boolean val="false"/>
                </dia:attribute>
                <dia:attribute name="text_colour">
                  <dia:color val="#000000"/>
                </dia:attribute>
                <dia:attribute name="line_colour">
                  <dia:color val="#000000"/>
                </dia:attribute>
                <dia:attribute name="line_width">
                  <dia:real val="0.10000000000000001"/>
                </dia:attribute>
                <dia:attribute name="line_style">
                  <dia:enum val="0"/>
                  <dia:real val="1"/>
                </dia:attribute>
                <dia:attribute name="corner_radius">
                  <dia:real val="0"/>
                </dia:attribute>
                <dia:attribute name="end_arrow">
                  <dia:enum val="22"/>
                </dia:attribute>
                <dia:attribute name="end_arrow_length">
                  <dia:real val="0.5"/>
                </dia:attribute>
                <dia:attribute name="end_arrow_width">
                  <dia:real val="0.5"/>
                </dia:attribute>
                <dia:attribute name="start_point_desc">
                  <dia:string>#many#</dia:string>
                </dia:attribute>
                <dia:attribute name="end_point_desc">
                  <dia:string>#1#</dia:string>
                </dia:attribute>
                <dia:attribute name="normal_font">
                  <dia:font family="monospace" style="0" name="Courier"/>
                </dia:attribute>
                <dia:attribute name="normal_font_height">
                  <dia:real val="0.59999999999999998"/>
                </dia:attribute>
                <dia:connections>
                  <dia:connection handle="0" to="O0" connection="15"/>
                  <dia:connection handle="1" to="O1" connection="12"/>
                </dia:connections>
              </dia:object>
            </root>
          </dia:diagram>
        xml

        @xml_doc  = Nokogiri::XML(input_xml)
        @xml_doc = @xml_doc.xpath("//dia:object[@type='Database - Reference']")

        @reference_parser.parse(@xml_doc)        
      end

      it "@reference_parser should return 'O2' when it receives the 'id' message" do
        @reference_parser.id.should == 'O2'
      end

      it "@reference_parser should not return 'nil' when it receives the 'start_point' message" do
        @reference_parser.start_point.should_not be_nil
      end

      it "@reference_parser should return '0' when it receives the 'start_point.handle' message" do
        @reference_parser.start_point.handle.should == '0'
      end

      it "@reference_parser should return 'O0' when it receives the 'start_point.target_object_id' message" do
        @reference_parser.start_point.target_object_id.should == 'O0'
      end

      it "@reference_parser should return '15' when it receives the 'start_point.connection' message" do
        @reference_parser.start_point.connection.should == '15'
      end

    end
  end
end
