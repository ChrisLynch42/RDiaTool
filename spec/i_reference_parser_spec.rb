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
              <dia:connections>
                <dia:connection handle="0" to="O0" connection="13"/>
                <dia:connection handle="1" to="O1" connection="12"/>
              </dia:connections>
            </root>
          </dia:diagram>
        xml

        @xml_doc  = Nokogiri::XML(input_xml)
        @xml_doc = @xml_doc.xpath('//root')

        @reference_parser.parse(@xml_doc)        
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

      it "@reference_parser should return '13' when it receives the 'start_point.connection' message" do
        @reference_parser.start_point.connection.should == '13'
      end

    end
  end
end
