require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe ObjectBuilder do

      describe "Check Class" do
        it "ObjectBuilder should have attribute 'tables' defined" do
          ObjectBuilder.instance_methods(false).include?(:tables).should be_true
        end

        it "ObjectBuilder should have attribute 'references' defined" do
          ObjectBuilder.instance_methods(false).include?(:references).should be_true
        end

        it "ObjectBuilder should have attribute 'initialize' defined" do
          ObjectBuilder.instance_methods(false).include?(:initialize).should be_true
        end

        it "ObjectBuilder should have attribute 'parse' defined" do
          ObjectBuilder.instance_methods(false).include?(:parse).should be_true
        end
      end

      describe "Check Instance of class" do
        before(:each) do 
#          @builder = new ObjectBuilder()
        end




      end
    end
  end
end
