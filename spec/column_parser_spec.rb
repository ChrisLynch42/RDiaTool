require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe "ColumnParser" do

      before(:each) do 
        @column_parser = ColumnParser.new()

        input_xml = <<-xml
          <?xml version="1.0" encoding="UTF-8"?>
            <dia:diagram xmlns:dia="http://www.lysator.liu.se/~alla/dia/">
            <root>
              <dia:composite type="table_attribute">
                <dia:attribute name="name">
                  <dia:string>#column_description#</dia:string>
                </dia:attribute>
                <dia:attribute name="type">
                  <dia:string>#varchar#</dia:string>
                </dia:attribute>
                <dia:attribute name="comment">
                  <dia:string>#xxx#</dia:string>
                </dia:attribute>
                <dia:attribute name="primary_key">
                  <dia:boolean val="false"/>
                </dia:attribute>
                <dia:attribute name="nullable">
                  <dia:boolean val="true"/>
                </dia:attribute>
                <dia:attribute name="unique">
                  <dia:boolean val="false"/>
                </dia:attribute>
              </dia:composite>
            </root>
          </dia:diagram>
        xml

        @xml_doc  = Nokogiri::XML(input_xml)
        @xml_doc = @xml_doc.xpath('//root')

        @column_parser.parse(@xml_doc)        
      end

      it "@column_parser should return 'column_description' when it receives the 'name' message" do
        @column_parser.name.should == 'column_description'
      end

      it "@column_parser should return 'varchar' when it receives the 'data_type' message" do
        @column_parser.name.should == 'varchar'
      end

      it "@column_parser should return 'xxx' when it receives the 'comment' message" do
        @column_parser.comment.should == 'xxx'
      end

      it "@column_parser should return true when it receives the 'nullable' message" do
        @column_parser.nullable.should == true
      end

      it "@column_parser should return false when it receives the 'unique' message" do
        @column_parser.unique.should == false
      end

      it "@column_parser should return false when it receives the 'primary_key' message" do
        @column_parser.primary_key.should == false
      end


    end
  end
end
