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

      end
    end
  end
end
