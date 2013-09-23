require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe "Class" do
      it "should have attribute 'table_name' defined" do
        ReferenceConnectionPoint.instance_methods(false).include?(:table_name).should be_true
      end

      it "should have attribute 'column_name' defined" do
        ReferenceConnectionPoint.instance_methods(false).include?(:column_name).should be_true
      end

      it "should have attribute 'column_order' defined" do
        ReferenceConnectionPoint.instance_methods(false).include?(:column_order).should be_true
      end      
    end

    describe "Database Connection Point" do

      before(:each) do
        @connectionPoint = ReferenceConnectionPoint.new()
        @connectionPoint.connection = 17
      end

      it "connection to column_order should return '1' when it receives message connection_to_column_order(12)" do
        result = @connectionPoint.connection_to_column_order(12)
        result.should == 1
      end

      it "connection to column_order should return '1' when it receives message connection_to_column_order(13)" do
        result = @connectionPoint.connection_to_column_order(13)
        result.should == 1
      end

      it "connection to column_order should return '3' when it receives message connection_to_column_order(17)" do
        result = @connectionPoint.connection_to_column_order(17)
        result.should == 3
      end

      it "should return '1' when it receives message column_order" do
        @connectionPoint.column_order.should == 3
      end

    end
  end
end
