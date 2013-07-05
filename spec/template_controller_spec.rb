require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe TemplateController do

      describe "Class" do
        it "TemplateController should have attribute 'template_directory' defined" do
          TemplateController.instance_methods(false).include?(:template_directory).should be_true
        end

        it "TemplateController should have attribute 'dia_file' defined" do
          TemplateController.instance_methods(false).include?(:dia_file).should be_true
        end

      end

      describe "Instance" do
        before(:each) do 
        end


      end
    end
  end
end
