require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    class TestTableParser < DiaParser
      include ITableParser
    end

    describe ITableParser do

    describe "Module" do
        it "ITableParser should have method 'parse' defined" do
          ITableParser.instance_methods(false).include?(:parse).should be_true
        end

    end


    describe "Instance" do
      before(:each) do 
        @table_parser = TestTableParser.new()

        input_xml = <<-xml
          <?xml version="1.0" encoding="UTF-8"?>
            <dia:diagram xmlns:dia="http://www.lysator.liu.se/~alla/dia/">
              <dia:object type="Database - Table" version="0" id="O0">
                <dia:attribute name="obj_pos">
                  <dia:point val="23.8,12.8"/>
                </dia:attribute>
                <dia:attribute name="obj_bb">
                  <dia:rectangle val="23.8,12.8;30.875,15.5"/>
                </dia:attribute>
                <dia:attribute name="meta">
                  <dia:composite type="dict"/>
                </dia:attribute>
                <dia:attribute name="elem_corner">
                  <dia:point val="23.8,12.8"/>
                </dia:attribute>
                <dia:attribute name="elem_width">
                  <dia:real val="7.0750000000000002"/>
                </dia:attribute>
                <dia:attribute name="elem_height">
                  <dia:real val="2.7000000000000002"/>
                </dia:attribute>
                <dia:attribute name="text_colour">
                  <dia:color val="#000000"/>
                </dia:attribute>
                <dia:attribute name="line_colour">
                  <dia:color val="#000000"/>
                </dia:attribute>
                <dia:attribute name="fill_colour">
                  <dia:color val="#ffffff"/>
                </dia:attribute>
                <dia:attribute name="line_width">
                  <dia:real val="0.10000000000000001"/>
                </dia:attribute>
                <dia:attribute name="name">
                  <dia:string>#column_set#</dia:string>
                </dia:attribute>
                <dia:attribute name="comment">
                  <dia:string>##</dia:string>
                </dia:attribute>
                <dia:attribute name="visible_comment">
                  <dia:boolean val="false"/>
                </dia:attribute>
                <dia:attribute name="tagging_comment">
                  <dia:boolean val="false"/>
                </dia:attribute>
                <dia:attribute name="underline_primary_key">
                  <dia:boolean val="true"/>
                </dia:attribute>
                <dia:attribute name="bold_primary_keys">
                  <dia:boolean val="false"/>
                </dia:attribute>
                <dia:attribute name="normal_font">
                  <dia:font family="monospace" style="0" name="Courier"/>
                </dia:attribute>
                <dia:attribute name="name_font">
                  <dia:font family="sans" style="80" name="Helvetica-Bold"/>
                </dia:attribute>
                <dia:attribute name="comment_font">
                  <dia:font family="sans" style="8" name="Helvetica-Oblique"/>
                </dia:attribute>
                <dia:attribute name="normal_font_height">
                  <dia:real val="0.80000000000000004"/>
                </dia:attribute>
                <dia:attribute name="name_font_height">
                  <dia:real val="0.69999999999999996"/>
                </dia:attribute>
                <dia:attribute name="comment_font_height">
                  <dia:real val="0.69999999999999996"/>
                </dia:attribute>
                <dia:attribute name="attributes">
                  <dia:composite type="table_attribute">
                    <dia:attribute name="name">
                      <dia:string>#column_id#</dia:string>
                    </dia:attribute>
                    <dia:attribute name="type">
                      <dia:string>#number#</dia:string>
                    </dia:attribute>
                    <dia:attribute name="comment">
                      <dia:string>##</dia:string>
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
                  <dia:composite type="table_attribute">
                    <dia:attribute name="name">
                      <dia:string>#set_id#</dia:string>
                    </dia:attribute>
                    <dia:attribute name="type">
                      <dia:string>#number#</dia:string>
                    </dia:attribute>
                    <dia:attribute name="comment">
                      <dia:string>##</dia:string>
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
                </dia:attribute>
              </dia:object>
          </dia:diagram>
        
        xml

        @xml_doc  = Nokogiri::XML(input_xml)
        @xml_doc = @xml_doc.xpath('//dia:object[@type="Database - Table"]')

        @table_parser.parse(@xml_doc)        
      end

      it "@table_parser.object_id should not return nil" do
        @table_parser.object_id.should_not be_nil
      end

      it "@table_parser.object_id should be 'O0'" do
        @table_parser.object_id.should == 'O0'
      end

      it "@table_parser should return 'column_set' when it receives the 'name' message" do
        @table_parser.name.should == 'column_set'
      end

      it "@table_parser should not return 'nil' when it recieves the 'columns' message" do
        @table_parser.columns.should_not be_nil
      end

      it "@table_parser.columns should return '2' when it recieves the 'size' message" do
        @table_parser.columns.size.should == 2
      end

      it "@table_parser.columns['set_id'] should not return 'nil'" do
        @table_parser.columns['set_id'].should_not be_nil
      end

      it "@table_parser.columns['set_id'] should return 'set_id' when it recieves the 'name' message" do
        @table_parser.columns['set_id'].name.should == 'set_id'
      end

      it "@table_parser should not return 'nil' when it recieves the 'columns_in_order' message" do
        @table_parser.columns.should_not be_nil
      end

      it "@table_parser.columns_in_order should return '2' when it recieves the 'size' message" do
        @table_parser.columns_in_order.size.should == 2
      end

      it "@table_parser.columns_in_order[0] should not return 'nil'" do
        @table_parser.columns_in_order[0].should_not be_nil
      end

      it "@table_parser.columns_in_order[0] should return 'set_id' when it recieves the 'name' message" do
        @table_parser.columns_in_order[0].name.should == 'column_id'
      end      
    end
    end
  end
end
