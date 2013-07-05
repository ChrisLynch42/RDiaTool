require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe TemplateController do

      describe "Class" do
        it "TemplateController should have attribute 'template' defined" do
          TemplateController.instance_methods(false).include?(:template).should be_true
        end

        it "TemplateController should have attribute 'dia_xml' defined" do
          TemplateController.instance_methods(false).include?(:dia_xml).should be_true
        end

        it "TemplateController should have attribute 'database_configuration_file' defined" do
          TemplateController.instance_methods(false).include?(:database_configuration_file).should be_true
        end
        

      end

      describe "Instance" do
        before(:each) do 
        end


      end
    end
  end
end
