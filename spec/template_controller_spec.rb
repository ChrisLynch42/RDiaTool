require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe TemplateController do

      describe "Class" do
        it "TemplateController should have attribute 'template' defined" do
          TemplateController.instance_methods(false).include?(:template).should be_true
        end

        it "TemplateController should have attribute 'dia_xml_file' defined" do
          TemplateController.instance_methods(false).include?(:dia_xml_file).should be_true
        end

        it "TemplateController should have attribute 'database_configuration' defined" do
          TemplateController.instance_methods(false).include?(:database_configuration).should be_true
        end
        

      end

      describe "Instance" do
        before(:each) do
          dia_file=File.dirname(__FILE__) + '/test.dia' 
          database_file=File.dirname(__FILE__) + '/test_database/development.sqlite3' 
          database_config= { 'adapter' => 'sqlite3', 'database' => database_file}
          @template_controller = TemplateController.new(dia_file,'RailsModel',database_config)
        end

        it "it should return false when it receives the 'database_connected?' message" do
          @template_controller.database_connected?().should be_false
        end

        it "it should return true when it receives the 'database_connected?' message" do
          @template_controller.connect()
          @template_controller.database_connected?().should be_true
        end
        
      end
    end
  end
end
