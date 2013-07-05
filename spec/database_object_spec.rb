require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe DatabaseObject do

      describe "Class" do
        it "should have attribute 'tables_by_name' defined" do
          DatabaseObject.instance_methods(false).include?(:tables_by_name).should be_true
        end

        it "should have attribute 'tables_by_id' defined" do
          DatabaseObject.instance_methods(false).include?(:tables_by_id).should be_true
        end


        it "should have attribute 'references_by_origin' defined" do
          DatabaseObject.instance_methods(false).include?(:references_by_origin).should be_true
        end

        it "should have attribute 'references_by_target' defined" do
          DatabaseObject.instance_methods(false).include?(:references_by_target).should be_true
        end


      end

      describe "Check Instance of class" do
      end
    end
  end
end