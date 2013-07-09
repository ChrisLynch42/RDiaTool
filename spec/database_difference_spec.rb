require 'spec_helper'

module RDiaTool
  module Database
    shared_examples_for "DatabaseDifference" do | test_parser |
      describe DatabaseDifference do

        describe "Check Class" do
          it "BasicTemplate should have attribute 'database' defined" do
            DatabaseDifference.instance_methods(false).include?(:database).should be_true
          end

          it "BasicTemplate should have attribute 'change' defined" do
            DatabaseDifference.instance_methods(false).include?(:change).should be_true
          end

        end


      end
    end
  end
end
