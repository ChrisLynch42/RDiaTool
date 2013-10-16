require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe DatabaseObjectFactory do

      describe "Class" do
        it "should have method 'database' defined" do
          DatabaseObjectFactory.instance_methods(false).include?(:database).should be_true
        end
        it "should have method 'table' defined" do
          DatabaseObjectFactory.instance_methods(false).include?(:table).should be_true
        end
        it "should have method 'column' defined" do
          DatabaseObjectFactory.instance_methods(false).include?(:column).should be_true
        end

      end

      describe "Instance" do

        before(:each) do 
          @factory = DatabaseObjectFactory.new(loadTestXML())
          @database_object = @factory.database()
        end

        it "@database_object should not be nil" do
          @database_object.should_not be_nil
        end

        it "should not return nil when it recieves the 'table' message" do
          @factory.table().should_not be_nil
        end

        it "should not return nil when it recieves the 'column' message" do
          @factory.column().should_not be_nil
        end


        it "should return an object when it recieves the 'table' message" do
          @factory.table().kind_of?(Class).should be_false
          @factory.table().kind_of?(Object).should be_true
        end

        it "should return an object when it recieves the 'column' message" do
          @factory.column().kind_of?(Class).should be_false
          @factory.column().kind_of?(Object).should be_true
        end


        it "should return an object with an ancestor of ITable when it recieves the 'table' message" do
          @factory.table().kind_of?(ITable).should be_true
        end

        it "should return an object with an ancestor of IColumn when it recieves the 'column' message" do
          @factory.column().kind_of?(IColumn).should be_true
        end


        describe "@database_object" do 
          it "tables_by_name should not be nil" do
            @database_object.tables_by_name.should_not be_nil
          end
          
          it "tables_by_id should not be nil" do
            @database_object.tables_by_id.should_not be_nil
          end


          it "references should not be nil" do
            @database_object.references.should_not be_nil
          end


          it "tables_by_name should be a Hash" do
            @database_object.tables_by_name.class.name.should == "Hash"
          end

          it "tables_by_id should be a Hash" do
            @database_object.tables_by_id.class.name.should == "Hash"
          end



          it "references should be a Hash" do
            @database_object.references.class.name.should == "Hash"
          end


          it "tables_by_name.size should be 27" do
            @database_object.tables_by_name.size.should == 27
          end

          it "tables_by_id.size should be 27" do
            @database_object.tables_by_id.size.should == 27
          end


          it "references.size should be 28" do
            @database_object.references.size.should == 28
          end


          it "get_point_table_name(references[O2]) should return 'column_set'" do
            point = @database_object.references['O2'].start_point
            table_name = @database_object.get_point_table_name(point)
            table_name.should == 'column_set'
          end

           it "get_point_column_name(references[O2]) should return 'column_id'" do
            point = @database_object.references['O2'].start_point
            column_name = @database_object.get_point_column_name(point)
            column_name.should == 'column_id'
          end

           it "set_reference_names should set names for all references" do
             @database_object.set_reference_names()
             point = @database_object.references['O2'].start_point
             point.table_name.should == 'column_set'
             point.column_name.should == 'column_id'
          end
        end


      end
    end
  end
end
