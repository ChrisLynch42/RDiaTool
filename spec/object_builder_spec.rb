#require 'spec_helper'
#require 'nokogiri'
#
#module RDiaTool
#  module Database
#
#    describe ObjectBuilder do
#
#      describe "Check Class" do
#        it "ObjectBuilder should have attribute 'tables' defined" do
#          ObjectBuilder.instance_methods(false).include?(:tables).should be_true
#        end
#
#        it "ObjectBuilder should have attribute 'references' defined" do
#          ObjectBuilder.instance_methods(false).include?(:references).should be_true
#        end
#
#      end
#
#      describe "Check Instance of class" do
#        before(:each) do 
#          @builder = ObjectBuilder.new(loadTestXML())
#        end
#
#        it "ObjectBuilder.tables should not be nil" do
#          @builder.tables.should_not be_nil
#        end
#
#        it "ObjectBuilder.references should not be nil" do
#          @builder.references.should_not be_nil
#        end
#
#        it "ObjectBuilder.tables should be a Hash" do
#          @builder.tables.class.name.should == "Hash"
#        end
#
#        it "ObjectBuilder.references should be a Hash" do
#          @builder.references.class.name.should == "Hash"
#        end
#
#        it "ObjectBuilder.tables.size should be 2" do
#          @builder.tables.size.should == 2
#        end
#
#      end
#    end
#  end
#end
