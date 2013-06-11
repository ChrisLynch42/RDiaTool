require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe BasicTemplate do

      before(:each) do 
        @basic_template = BasicTemplate.new()
      end

      it "BasicTemplate should have attribute 'target_directory' defined" do
        BasicTemplate.instance_methods(false).include?(:target_directory).should be_true
      end

      it "BasicTemplate should have attribute 'file_name' defined" do
        BasicTemplate.instance_methods(false).include?(:file_name).should be_true
      end

    end
  end
end
