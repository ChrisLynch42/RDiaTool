require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe DatabaseObjectFactory do

      describe "Class" do
        it "should have method 'database' defined" do
          DatabaseObjectFactory.instance_methods(false).include?(:database).should be_true
        end

      end

      describe "Instance" do
        before(:each) do 
          @factory = DatabaseObjectFactory.new(loadTestXML())
          @database_object = @factory.database()
        end

        it "ObjectBuilder.tables_by_name should not be nil" do
          @database_object.tables_by_name.should_not be_nil
        end

        it "ObjectBuilder.references_by_origin should not be nil" do
          @database_object.references_by_origin.should_not be_nil
        end

        it "ObjectBuilder.tables_by_name should be a Hash" do
          @database_object.tables_by_name.class.name.should == "Hash"
        end

        it "ObjectBuilder.references_by_origin should be a Hash" do
          @database_object.references_by_origin.class.name.should == "Hash"
        end

        it "ObjectBuilder.tables_by_name.size should be 2" do
          @database_object.tables_by_name.size.should == 2
        end

        it "ObjectBuilder.references_by_origin.size should be 2" do
          @database_object.references_by_origin.size.should == 1
        end


      end
    end
  end
end
