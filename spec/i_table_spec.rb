require 'spec_helper'
require 'nokogiri'

module RDiaLib
  module Database

    describe ITable do

      describe "Module" do
        it "should have method 'name' defined" do
          ITable.instance_methods(false).include?(:name).should be_true
        end
        it "should have method 'columns' defined" do
          ITable.instance_methods(false).include?(:columns).should be_true
        end
        it "should have method 'columns_in_order' defined" do
          ITable.instance_methods(false).include?(:columns_in_order).should be_true
        end

        it "should have method 'references' defined" do
          ITable.instance_methods(false).include?(:references).should be_true
        end

        it "should have method 'type' defined" do
          ITable.instance_methods(false).include?(:type).should be_true
        end        
        
      end


    end
  end
end
