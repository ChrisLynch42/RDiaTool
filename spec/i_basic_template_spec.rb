require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe IBasicTemplate do

      describe "Check Class" do
        it "BasicTemplate should have attribute 'directories' defined" do
          IBasicTemplate.instance_methods(false).include?(:directories).should be_true
        end

        it "BasicTemplate should have attribute 'templates' defined" do
          IBasicTemplate.instance_methods(false).include?(:templates).should be_true
        end

        it "BasicTemplate should have attribute 'generate' defined" do
          IBasicTemplate.instance_methods(false).include?(:generate).should be_true
        end

        it "BasicTemplate should have attribute 'base_directory' defined" do
          IBasicTemplate.instance_methods(false).include?(:base_directory).should be_true
        end
      end

      describe "Check Instance of class" do
        class TestBasicTemplate
          include IBasicTemplate

        end

        before(:each) do 
          @basic_template = TestBasicTemplate.new()
        end

        it "@basic_template should not be nil" do
          @basic_template.should_not be_nil
        end

      end
    end
  end
end
