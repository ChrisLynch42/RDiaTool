require 'spec_helper'

module RDiaTool
  module Database

    describe RailsModelTemplate do

      describe "Check Class" do
        it "BasicTemplate should have attribute 'generate' defined" do
          RailsModelTemplate.instance_methods(false).include?(:generate).should be_true
        end

      end

      describe "Check Instance of class" do
        before(:each) do 
        end

      end
    end
  end
end
