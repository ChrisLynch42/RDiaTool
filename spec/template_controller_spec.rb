require 'spec_helper'

module RDiaTool
  module Database

    describe TemplateController do

      describe "Class" do
        it "TemplateController should have attribute 'template' defined" do
          TemplateController.instance_methods(false).include?(:template).should be_true
        end

        it "TemplateController should have attribute 'template_instance' defined" do
          TemplateController.instance_methods(false).include?(:template_instance).should be_true
        end


        it "TemplateController should have attribute 'dia_xml' defined" do
          TemplateController.instance_methods(false).include?(:dia_xml).should be_true
        end

        it "TemplateController should have attribute 'database_configuration' defined" do
          TemplateController.instance_methods(false).include?(:database_configuration).should be_true
        end
        
        it "TemplateController should have attribute 'database_difference' defined" do
          TemplateController.instance_methods(false).include?(:database_difference).should be_true
        end

        it "TemplateController should have attribute 'target_directory' defined" do
          TemplateController.instance_methods(false).include?(:target_directory).should be_true
        end

      end

      describe "Instance" do
       
        before(:each) do
          dia_xml=loadTestXML()
          base_dir=File.dirname(__FILE__)
          @temp_database=base_dir + "/temp_database"
          @template_dir=base_dir + "/template_test"
          unless FileTest::directory?(@temp_database)
            Dir::mkdir(@temp_database)
          end
          file_name='development.sqlite3'
          database_file= base_dir + '/test_database/' + file_name
          FileUtils.cp(database_file,@temp_database)
          database_file= @temp_database + '/' + file_name
          database_config= { 'adapter' => 'sqlite3', 'database' => database_file}
          @template_controller = RDiaTool::Database::TemplateController.new(dia_xml,'RailsModel',@template_dir,database_config)
        end

        after(:each) do
          FileUtils.rm_rf(@temp_database)
        end

        it "it should return false when it receives the 'database_connected?' message" do
          @template_controller.database_connected?().should be_false
        end

        it "it should return true when it receives the 'database_connected?' message" do
          @template_controller.connect()
          @template_controller.database_connected?().should be_true
        end

        it "it should return true when it receives the 'instantiate_template' message" do
          @template_controller.instantiate_template().should be_true
        end

        it "database_configuration should not be nil" do
          @template_controller.dia_xml.should_not be_nil
        end

        it "dia_xml should not be nil" do
          @template_controller.dia_xml.should_not be_nil
        end

        it "template should not be nil" do
          @template_controller.template.should_not be_nil
        end

        it "template_instance should not be nil" do
          @template_controller.instantiate_template()
          @template_controller.template_instance.should_not be_nil
        end

        it "database_difference should not be nil" do
          @template_controller.analyze()
          @template_controller.database_difference.should_not be_nil
        end

        describe "DatabaseDifference Instance" do
          
          before(:each) do
            @template_controller.analyze()
          end

          it "should not return nil receives the 'create' message" do
            @template_controller.database_difference.create.should_not be_nil
          end

          it "should return a hash when it receives the 'create' message" do
            @template_controller.database_difference.create.class.to_s.should == 'Hash'
          end

          describe "@template_controller.database_difference.create" do
            it "should a size of 2" do
              @template_controller.database_difference.create.length.should == 2
            end

            it "should contain a key of 'column_set'" do
              @template_controller.database_difference.create.include?('column_set').should be_true
            end

            describe "@template_controller.database_difference.create['column_set']" do              
              it "should not be nil" do
                @template_controller.database_difference.create['column_set'].should_not be_nil
              end

              it "should be an object of Hash class" do
                @template_controller.database_difference.create['column_set'].class.eql?(DatabaseChange).should be_true
              end

              it "should not return nil when 'add()' is called " do
                @template_controller.database_difference.create['column_set'].add().should_not be_nil
              end 

              it "should return 2 when 'add().length' is called" do
                @template_controller.database_difference.create['column_set'].add().length.should == 2
              end

              it "should not return nil when 'add()[column_id]' is called " do
                @template_controller.database_difference.create['column_set'].add()['column_id'].should_not be_nil
              end 

              it "should return 'number' when 'add()['column_id'].data_type' is called " do
                @template_controller.database_difference.create['column_set'].add()['column_id'].data_type.should == 'number'
              end             
            end

            describe "@template_controller.execute_template()" do
              before(:each) do
                @template_controller.execute_template()
              end

              after(:each) do
                #FileUtils.rm_rf(Dir.glob(@template_dir + '/*'))
              end              
              it "should create 'column_set.sh' file" do
                File.exists?(@template_dir + "/column_set_create.sh").should be_true
              end

            end 

          end

        end
      end
    end
  end
end
