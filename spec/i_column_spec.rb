require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe IColumn do

      describe "Module" do
        it "should have method 'name' defined" do
          IColumn.instance_methods(false).include?(:name).should be_true
        end
        it "should have method 'data_type' defined" do
          IColumn.instance_methods(false).include?(:data_type).should be_true
        end
        it "should have method 'primary_key' defined" do
          IColumn.instance_methods(false).include?(:primary_key).should be_true
        end
        it "should have method 'nullable' defined" do
          IColumn.instance_methods(false).include?(:nullable).should be_true
        end
        it "should have method 'unique' defined" do
          IColumn.instance_methods(false).include?(:unique).should be_true
        end
        it "should have method 'comment' defined" do
          IColumn.instance_methods(false).include?(:comment).should be_true
        end

        it "should have method 'references' defined" do
          IColumn.instance_methods(false).include?(:references).should be_true
        end

      end


    end
  end
end
