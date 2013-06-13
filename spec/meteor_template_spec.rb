require 'spec_helper'
require 'nokogiri'

module RDiaTool
  module Database

    describe MeteorTemplate do

      describe "Check Class" do
      end

      describe "Check Instance of class" do

        before(:each) do 
          @base_directory = File.dirname(__FILE__)
          @meteor_template = MeteorTemplate.new()
          @meteor_template.base_directory = @base_directory + '/template_test'
        end

        after(:each) do 
          FileUtils.rm_rf(Dir.glob(@meteor_template.base_directory + '/*'))
        end


        it "@meteor_template should not be nil" do
          @meteor_template.should_not be_nil
        end

        it "@meteor_template attribute directories should contain 'client', 'server' and 'public'" do
          @meteor_template.directories.include?('client').should be_true
          @meteor_template.directories.include?('server').should be_true
          @meteor_template.directories.include?('public').should be_true
        end

        it "@meteor_template should create directories 'client'" do
          @meteor_template.generate()
          Dir.exists?(@meteor_template.base_directory + '/client').should be_true
        end

        it "@meteor_template should create directories 'server' when it recieves the 'generate' message" do
          @meteor_template.generate()
          Dir.exists?(@meteor_template.base_directory + '/server').should be_true
        end

        it "@meteor_template should create directories 'public' when it recieves the 'generate' message" do
          @meteor_template.generate()
          Dir.exists?(@meteor_template.base_directory + '/public').should be_true
        end

      end
    end
  end
end
