require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe ITable do

      describe "Module" do
        it "should have method 'name' defined" do
          ITable.instance_methods(false).include?(:name).should be_true
        end
        it "should have method 'columns' defined" do
          ITable.instance_methods(false).include?(:columns).should be_true
        end

      end


    end
  end
end
