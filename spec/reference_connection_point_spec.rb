require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database
    describe "Database Connection Point" do
      
      before(:each) do
        @connectionPoint = ReferenceConnectionPoint.new()
      end

      it "connection to column_order should return '1' when it receives message connection_to_column_order(12)" do
        result = @connectionPoint.connection_to_column_order(12)
        result.should == 1
      end

      it "connection to column_order should return '1' when it receives message connection_to_column_order(13)" do
        result = @connectionPoint.connection_to_column_order(13)
        result.should == 1
      end

      it "connection to column_order should return '1' when it receives message connection_to_column_order(17)" do
        result = @connectionPoint.connection_to_column_order(17)
        result.should == 3
      end

    end
  end
end
