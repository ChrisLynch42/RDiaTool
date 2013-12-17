require 'spec_helper'
require 'nokogiri'

module RDiaLib

    describe DiaConnectionPoint do

      describe "Check Class" do
        it "should have attribute 'target_object_id' defined" do
          DiaConnectionPoint.instance_methods(false).include?(:target_object_id).should be_true
        end

        it "should have attribute 'description' defined" do
          DiaConnectionPoint.instance_methods(false).include?(:description).should be_true
        end

        it "should have attribute 'handle' defined" do
          DiaConnectionPoint.instance_methods(false).include?(:handle).should be_true
        end

        it "should have attribute 'connection' defined" do
          DiaConnectionPoint.instance_methods(false).include?(:connection).should be_true
        end
      end

      describe "Check Instance of class" do
        #saved for subclasses
      end
    end
end
