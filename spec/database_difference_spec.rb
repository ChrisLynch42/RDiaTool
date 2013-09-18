require 'spec_helper'

module RDiaTool
  module Database
      describe IDatabaseDifference do

        describe "Check Class" do
          it "BasicTemplate should have attribute 'database' defined" do
            IDatabaseDifference.instance_methods(false).include?(:database).should be_true
          end

          it "BasicTemplate should have attribute 'change' defined" do
            IDatabaseDifference.instance_methods(false).include?(:change).should be_true
          end

        end


    end
  end
end
