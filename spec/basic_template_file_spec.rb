require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe BasicTemplateFile do

      describe "Check Class" do
        it "BasicTemplate should have attribute 'target_directory' defined" do
          BasicTemplateFile.instance_methods(false).include?(:target_directory).should be_true
        end

        it "BasicTemplate should have attribute 'target_file_name' defined" do
          BasicTemplateFile.instance_methods(false).include?(:target_file_name).should be_true
        end

        it "BasicTemplate should have attribute 'source_file_name' defined" do
          BasicTemplateFile.instance_methods(false).include?(:source_file_name).should be_true
        end

        it "BasicTemplate should have attribute 'set_file_name' defined" do
          BasicTemplateFile.instance_methods(false).include?(:set_file_name).should be_true
        end
      end

      describe "Check Instance of class" do
        @name = 'test'
        before(:each) do 
          @basic_template_file = BasicTemplateFile.new()
          @basic_template_file.set_file_name(@name)
        end


        it "@basic_template_file attribute target_file_name should be '#{@name}'" do
          @basic_template_file.target_file_name.should == @name
        end

        it "@basic_template_file attribute source_file_name should be '#{@name}'" do
          @basic_template_file.source_file_name.should == @name
        end
        
        @param1='test1'
        @param2='test2'
        @param3='test3'

        it "test_template_file.new(#{@param1},#{@param2},#{@param3}) should have a target_directory of '#{@param1}'" do
          test_template_file= BasicTemplateFile.new(@param1,@param2,@param3)
          @basic_template_file.target_directory.should == @param1
        end

        it "test_template_file.new(#{@param1},#{@param2},#{@param3}) should have a target_file_name of '#{@param2}'" do
          test_template_file= BasicTemplateFile.new(@param1,@param2,@param3)
          @basic_template_file.target_file_name.should == @param2
        end

        it "test_template_file.new(#{@param1},#{@param2},#{@param3}) should have a source_file_name of '#{@param3}'" do
          test_template_file= BasicTemplateFile.new(@param1,@param2,@param3)
          @basic_template_file.source_file_name.should == @param3
        end

        it "test_template_file.new(#{@param1},#{@param2}) should have a source_file_name of '#{@param2}'" do
          test_template_file= BasicTemplateFile.new(@param1,@param2)
          @basic_template_file.source_file_name.should == @param2
        end


      end
    end
  end
end
