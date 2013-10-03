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

        it "TemplateController should have attribute 'options' defined" do
          TemplateController.instance_methods(false).include?(:options).should be_true
        end
      end

      describe "Instance" do
        describe "Create missing tables" do 

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
            options = {:rails_dir => nil, :target_dir => @template_dir, :template => 'RailsModel' }            
            @template_controller = RDiaTool::Database::TemplateController.new(dia_xml,options)
            @template_controller.database_configuration=database_config
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

                it "should return 5 when 'add().length' is called" do
                  @template_controller.database_difference.create['column_set'].add().length.should == 5
                end

                it "should not return nil when 'add()[column_id]' is called " do
                  @template_controller.database_difference.create['column_set'].add()['column_id'].should_not be_nil
                end 

                it "should return 'Reference' when 'add()['column_id'].data_type' is called " do
                  @template_controller.database_difference.create['column_set'].add()['column_id'].data_type.should == 'belongs_to'
                end 

                it "should return 'integer' when 'add()['set_id'].data_type' is called " do
                  @template_controller.database_difference.create['column_set'].add()['set_id'].data_type.should == 'integer'
                end 

                it "should return 'string' when 'add()['changeme'].data_type' is called " do
                  @template_controller.database_difference.create['column_set'].add()['changeme'].data_type.should == 'string'
                end

                it "should return 'string' when 'add()['convertme'].data_type' is called " do
                  @template_controller.database_difference.create['column_set'].add()['convertme'].data_type.should == 'string'
                end
              end

              describe "@template_controller.execute_template()" do
                before(:each) do
                  @template_controller.execute_template()
                end

                after(:each) do
                  FileUtils.rm_rf(Dir.glob(@template_dir + '/*'))
                end
                it "should create 'table_create*.sh' file" do
                  Dir.glob(@template_dir + "/tables_create*.sh").empty?().should be_false
                end

              end 

            end

          end
        end
        describe "Create one table and change second table" do
          before(:each) do
            dia_xml=loadTestXML()
            base_dir=File.dirname(__FILE__)
            @temp_database=base_dir + "/temp_database"
            @template_dir=base_dir + "/template_test"
            unless FileTest::directory?(@temp_database)
              Dir::mkdir(@temp_database)
            end
            file_name='change.sqlite3'
            database_file= base_dir + '/test_database/' + file_name
            FileUtils.cp(database_file,@temp_database)
            database_file= @temp_database + '/' + file_name
            database_config= { 'adapter' => 'sqlite3', 'database' => database_file}
            options = {:rails_dir => nil, :target_dir => @template_dir, :template => 'RailsModel' }            
            @template_controller = RDiaTool::Database::TemplateController.new(dia_xml,options)
            @template_controller.database_configuration=database_config
          end

          after(:each) do
            FileUtils.rm_rf(@temp_database)
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

            it "should not return nil receives the 'change' message" do
              @template_controller.database_difference.change.should_not be_nil
            end

            it "should return a hash when it receives the 'change' message" do
              @template_controller.database_difference.change.class.to_s.should == 'Hash'
            end
            describe "@template_controller.database_difference.change" do
              it "should a size of 2" do
                @template_controller.database_difference.change.length.should == 1
              end

              it "should contain a key of 'column_set'" do
                @template_controller.database_difference.change.include?('column_set').should be_true
              end

              it "should return 1 when'change[column_set].remove().length'" do
                @template_controller.database_difference.change['column_set'].remove().length.should == 1
              end              
              it "should return 3 when'change[column_set].add().length'" do
                @template_controller.database_difference.change['column_set'].add().length.should == 3
              end             
              it "should return 1 when'change[column_set].modify().length'" do
                @template_controller.database_difference.change['column_set'].modify().length.should == 1
              end             
              
              describe "@template_controller.execute_template()" do
                before(:each) do
                  @template_controller.execute_template()
                end

                after(:each) do
                  FileUtils.rm_rf(Dir.glob(@template_dir + '/*'))
                end
                it "should create 'tables_add_remove_command_line*.sh' file" do
                  Dir.glob(@template_dir + "/tables_add_remove_command_line*.sh").empty?().should be_false
                end
                it "should create 'tables_create_command_line*.sh' file" do
                  Dir.glob(@template_dir + "/tables_add_remove_command_line*.sh").empty?().should be_false
                end
                it "should create 'tables_migration_change*.sh' file" do
                  Dir.glob(@template_dir + "/tables_migration_change*.sh").empty?().should be_false
                end                
              end 
            end
          end          

        end
        describe "Work with RailsModel project" do
          before(:each) do
            dia_xml=loadTestXML()
            base_dir=File.dirname(__FILE__)
            @temp_rails=base_dir + "/temp_rails"
            @rails_dir=base_dir + "/test_rails"
            unless FileTest::directory?(@temp_rails)
              Dir::mkdir(@temp_rails)
            end
            @template_dir=base_dir + "/template_test"
            unless FileTest::directory?(@template_dir)
              Dir::mkdir(@template_dir)
            end
            

            FileUtils.cp_r(Dir.glob(@rails_dir + '/*'),@temp_rails, :remove_destination => true)
            @temp_rails = @temp_rails + '/TestRails'
            options = {:rails_dir => @temp_rails, :target_dir => @template_dir, :template => 'RailsModel' }
            @template_controller = RDiaTool::Database::TemplateController.new(dia_xml,options)
          end

          after(:each) do
            FileUtils.rm_rf(@temp_rails)
          end

          it "@template_controller should not return nil when 'database_configuration' is called" do
            @template_controller.database_configuration.should_not be_nil
          end

          it "@template_controller.database_configuration should not return nil when '[development]' is called" do
            @template_controller.database_configuration['development'].should_not be_nil
          end

          it "@template_controller.database_configuration[development] should not return nil when '[database]' is called" do
            @template_controller.database_configuration['development']['database'].should_not be_nil
          end          

          describe "@template_controller.execute_template()" do
            before(:each) do
              @template_controller.execute_template()
            end

            after(:each) do
              FileUtils.rm_rf(Dir.glob(@template_dir + '/*'))
            end
            
            it "should create 'table_create*.sh' file" do
              Dir.glob(@template_dir + "/tables_create*.sh").empty?().should be_false
            end

          end
        end        
        describe "Work with RailsModelContinuous project to create tables" do
          before(:each) do
            dia_xml=loadTestXML()
            base_dir=File.dirname(__FILE__)
            @temp_rails=base_dir + "/temp_rails"
            @rails_dir=base_dir + "/test_rails"
            unless FileTest::directory?(@temp_rails)
              Dir::mkdir(@temp_rails)
            end
            @migration_dir=@temp_rails + "/TestRails/db/migrate"
            @model_dir=@temp_rails + "/TestRails/app/models"
            

            FileUtils.cp_r(Dir.glob(@rails_dir + '/*'),@temp_rails, :remove_destination => true)
            @temp_rails = @temp_rails + '/TestRails'
            options = {:rails_dir => @temp_rails, :template => 'RailsModelContinuous' }
            @template_controller = RDiaTool::Database::TemplateController.new(dia_xml,options)
          end

          after(:each) do
            #FileUtils.rm_rf(@temp_rails)
          end
          it "@template_controller should not return nil when 'database_configuration' is called" do
            @template_controller.database_configuration.should_not be_nil
          end

          it "@template_controller.database_configuration should not return nil when '[development]' is called" do
            @template_controller.database_configuration['development'].should_not be_nil
          end

          it "@template_controller.database_configuration[development] should not return nil when '[database]' is called" do
            @template_controller.database_configuration['development']['database'].should_not be_nil
          end          

          describe "@template_controller.execute_template()" do

            before(:each) do
              @template_controller.execute_template()
            end

            it "should create '*create_column.rb' file" do
              Dir.glob(@migration_dir + "/*create_column.rb").empty?().should be_false
            end

            it "should create '*create_column_set.rb' file" do
              Dir.glob(@migration_dir + "/*create_column_set.rb").empty?().should be_false
            end 

             it "should create 'column.rb' model file" do
              Dir.glob(@model_dir + "/column.rb").empty?().should be_false
            end

          end          

        end

        describe "Work with RailsModelContinuous project to change tables" do
          before(:each) do
            dia_xml=loadTestXML()
            base_dir=File.dirname(__FILE__)
            @temp_rails=base_dir + "/temp_rails"
            @rails_dir=base_dir + "/test_rails"
            unless FileTest::directory?(@temp_rails)
              Dir::mkdir(@temp_rails)
            end
            @migration_dir=@temp_rails + "/TestRails/db/migrate"
            @model_dir=@temp_rails + "/TestRails/app/models"
            @database_dir=base_dir + "/test_database"

            FileUtils.cp_r(Dir.glob(@rails_dir + '/*'),@temp_rails, :remove_destination => true)
            @temp_rails = @temp_rails + '/TestRails'
            FileUtils.cp(@database_dir + '/change.sqlite3',@temp_rails + '/db/development.sqlite3')
            options = {:rails_dir => @temp_rails, :template => 'RailsModelContinuous' }
            @template_controller = RDiaTool::Database::TemplateController.new(dia_xml,options)
            open(@model_dir + "/column.rb", 'a') { |f|
              f.puts "\n###modified"
            }
            if File.exists?(@model_dir + "/column.rb")
              file = File.open(@model_dir + "/column.rb",'r')
              contents=file.read()
              file.close()
              contents.sub!(/###Begin/,'cattle')
              file = File.open(@model_dir + "/column.rb",'w+')
              file.write(contents)
              file.close()
            end           
          end

          after(:each) do
            #FileUtils.rm_rf(@temp_rails)
          end

          describe "@template_controller.execute_template()" do

            before(:each) do
              @template_controller.execute_template()
            end

            it "should create '*create_column.rb' file" do
              Dir.glob(@migration_dir + "/*change_column_set.rb").empty?().should be_false
            end

            it "should not have the text 'cattle' in the 'column.rb' file" do

              if File.exists?(@model_dir + "/column.rb")
                file = File.open(@model_dir + "/column.rb",'r')
                contents=file.read()
                contents.include?('cattle').should_not be_true
                file.close()
              end 
            end

          end          
        end        
      end

    end
  end
end
