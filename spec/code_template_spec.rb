require 'spec_helper'
require 'nokogiri'

module RDiaLib
  module Database

    describe CodeTemplate do

      describe "Check Class" do
      end

      describe "Check Instance of class" do

        before(:each) do 
          @base_directory = File.dirname(__FILE__)
          @code_template = CodeTemplate.new()
          @code_template.base_directory = @base_directory + '/template_test'
        end

        after(:each) do 
          FileUtils.rm_rf(Dir.glob(@code_template.base_directory + '/*'))
        end


        it "@code_template should not be nil" do
          @code_template.should_not be_nil
        end

        it "@code_template attribute directories should contain 'client', 'server' and 'public'" do
          @code_template.directories.include?('client').should be_true
          @code_template.directories.include?('server').should be_true
          @code_template.directories.include?('public').should be_true
        end

        it "@code_template attribute templates should contain 'server/bootstrap.js'" do
          @code_template.templates[0].target_directory.should == 'server'
          @code_template.templates[0].source_file_name.should == 'bootstrap.js'
        end

        it "@code_template attribute templates should contain 'server/publish.js'" do
          @code_template.templates[1].target_directory.should == 'server'
          @code_template.templates[1].source_file_name.should == 'publish.js'
        end

        it "@code_template should create directories 'client'" do
          @code_template.generate()
          Dir.exists?(@code_template.base_directory + '/client').should be_true
        end

        it "@code_template should create directories 'server' when it recieves the 'generate' message" do
          @code_template.generate()
          Dir.exists?(@code_template.base_directory + '/server').should be_true
        end

        it "@code_template should create directories 'public' when it recieves the 'generate' message" do
          @code_template.generate()
          Dir.exists?(@code_template.base_directory + '/public').should be_true
        end

      end
    end
  end
end
