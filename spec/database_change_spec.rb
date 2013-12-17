require 'spec_helper'

module RDiaLib
  module Database
    describe DatabaseChange do

      describe "Class" do
        it "should have attribute 'add' defined" do
          DatabaseChange.instance_methods(false).include?(:add).should be_true
        end

        it "should have attribute 'remove' defined" do
          DatabaseChange.instance_methods(false).include?(:remove).should be_true
        end

        it "should have attribute 'modify' defined" do
          DatabaseChange.instance_methods(false).include?(:modify).should be_true
        end

        it "should have attribute 'table' defined" do
          DatabaseChange.instance_methods(false).include?(:table).should be_true
        end

      end


    end
  end
end
