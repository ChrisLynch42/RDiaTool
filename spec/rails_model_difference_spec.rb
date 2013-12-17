require 'spec_helper'

module RDiaLib
  module Database

    describe RailsModelDifference do

      describe "Class" do
        it "should have attribute 'options' defined" do
          RailsModelDifference.instance_methods(false).include?(:options).should be_true
        end

        it "should have attribute 'root?' defined" do
          RailsModelDifference.instance_methods(false).include?(:root?).should be_true
        end        
      end

      describe "Instance" do
        before(:each) do 
        end

      end
    end
  end
end
