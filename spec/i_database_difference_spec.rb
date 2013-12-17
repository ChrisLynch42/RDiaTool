require 'spec_helper'

module RDiaLib
  module Database
      describe IDatabaseDifference do

        describe "Check Class" do
          it "BasicTemplate should have attribute 'database' defined" do
            IDatabaseDifference.instance_methods(false).include?(:database).should be_true
          end

          it "BasicTemplate should have attribute 'change' defined" do
            IDatabaseDifference.instance_methods(false).include?(:change).should be_true
          end

          it "BasicTemplate should have attribute 'create' defined" do
            IDatabaseDifference.instance_methods(false).include?(:create).should be_true
          end

          it "BasicTemplate should have attribute 'drop' defined" do
            IDatabaseDifference.instance_methods(false).include?(:drop).should be_true
          end

          it "BasicTemplate should have attribute 'dia_xml' defined" do
            IDatabaseDifference.instance_methods(false).include?(:dia_xml).should be_true
          end
          
          it "BasicTemplate should have attribute 'database_tables' defined" do
            IDatabaseDifference.instance_methods(false).include?(:database_tables).should be_true
          end          

          it "BasicTemplate should have attribute 'translation_hash' defined" do
            IDatabaseDifference.instance_methods(false).include?(:translation_hash).should be_true
          end                    
        end


    end
  end
end
