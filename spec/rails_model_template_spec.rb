require 'spec_helper'

module RDiaLib
  module Database

    describe RailsModelTemplate do

      describe "Class" do
        it "should have attribute 'generate' defined" do
          RailsModelTemplate.instance_methods(false).include?(:generate).should be_true
        end

        it "should have attribute 'database_difference' defined" do
          RailsModelTemplate.instance_methods(false).include?(:database_difference).should be_true
        end        
      end

      describe "Instance" do
        before(:each) do 
        end

      end
    end
  end
end
