require 'spec_helper'

module RDiaTool
  module Database

    describe TemplateController do

      describe "Class" do
        it "TemplateController should have attribute 'model_template' defined" do
          TemplateController.instance_methods(false).include?(:model_template).should be_true
        end

        it "TemplateController should have attribute 'view_template' defined" do
          TemplateController.instance_methods(false).include?(:view_template).should be_true
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
            options = {:rails_dir => nil, :model => 'Rails' }            
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

          it "database_configuration should not be nil" do
            @template_controller.dia_xml.should_not be_nil
          end

          it "dia_xml should not be nil" do
            @template_controller.dia_xml.should_not be_nil
          end

          it "model_template should not be nil" do
            @template_controller.model_template.should_not be_nil
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

            describe "@template_controller.database_difference.database" do

              it "should return '28' when it recieves the 'references.length" do
                @template_controller.database_difference.database.references.length.should == 28
              end

              it "should return 'O3' when it recieves the 'references[O50].start_point.target_object_id" do
                @template_controller.database_difference.database.references['O50'].start_point.target_object_id.should == 'O3'
              end

              it "should return 'O48' when it recieves the 'references[O50].end_point.target_object_id" do
                @template_controller.database_difference.database.references['O50'].end_point.target_object_id.should == 'O48'
              end

              it "should return '27' when it recieves the 'tables_by_name.length" do
                @template_controller.database_difference.database.tables_by_name.length.should == 27
              end

              it "should return '1' when it recieves the 'tables_by_name[column_set].references.length" do
                @template_controller.database_difference.database.tables_by_name['column'].references.length.should == 1
              end

              it "should return '2' when it recieves the 'tables_by_name[scenarios_characters].references.length" do
                @template_controller.database_difference.database.tables_by_name['scenarios_characters'].references.length.should == 2              end

            end

            describe "@template_controller.database_difference.create" do
              it "should a size of 27" do
                @template_controller.database_difference.create.length.should == 27
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
            options = {:rails_dir => nil, :model => 'Rails' }            
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

            it "should return a hash when it receives the 'drop' message" do
              @template_controller.database_difference.drop.class.to_s.should == 'Hash'
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
              
            end

            describe "@template_controller.database_difference.drop" do
              it "should a size of 1" do
                @template_controller.database_difference.drop.length.should == 1
              end

              it "should contain a key of 'delete_me'" do
                @template_controller.database_difference.drop.include?('delete_me').should be_true
              end              
            end            
          end          

        end
        describe "Work with Rails project to create tables" do
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
            options = {:rails_dir => @temp_rails, :model => 'Rails', :template => 'MasterSlave' }
            @template_controller = RDiaTool::Database::TemplateController.new(dia_xml,options)
          end

          after(:each) do
            #FileUtils.rm_rf(@temp_rails)
          end

          it "it should return true when it receives the 'get_template_object(RailsModelTemplate)' message" do
            @template_controller.get_template_object('RailsModelTemplate').should_not be_nil
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


            it "should create '*drop_delete_me.rb' file" do
              Dir.glob(@migration_dir + "/*drop_delete_me.rb").empty?().should be_false
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

            describe "@template_controller.get_template_object(@template_controller.model_template)" do

              it "should not return nil '@template_controller.get_template_object(@template_controller.model_template)' is called" do
                 @template_controller.get_template_object(@template_controller.model_template).should_not be_nil
              end 

               it "should not return nil '@template_controller.get_template_object(@template_controller.model_template).belongs_to' is called" do
                 template_object = @template_controller.get_template_object(@template_controller.model_template)
                 template_object.belongs_to.should_not be_nil                 
              end             

              it "should return 2 when 'belongs_to[scenarios_characters].length' is called" do
                 @template_controller.get_template_object( @template_controller.model_template).belongs_to['scenarios_characters'].length.should == 2
              end

              it "should return 9 when 'has_many_through[characters].length' is called" do
                 @template_controller.get_template_object(@template_controller.model_template).has_many_through['characters'].length.should == 9
              end              
            end

          end          

        end

        describe "Work with Rails project to change tables" do
          before(:each) do
            dia_xml=loadTestXML()
            base_dir=File.dirname(__FILE__)
            @temp_rails=base_dir + "/temp_rails"
            @rails_dir=base_dir + "/test_rails"
            unless FileTest::directory?(@temp_rails)
              Dir::mkdir(@temp_rails)
            end
            @migration_dir=@temp_rails + "/TestRails/db/migrate"
            @controller_dir=@temp_rails + "/TestRails/app/controllers"
            @view_dir=@temp_rails + "/TestRails/app/views"
            @config_dir=@temp_rails + "/TestRails/config"
            @model_dir=@temp_rails + "/TestRails/app/models"
            @database_dir=base_dir + "/test_database"

            FileUtils.cp_r(Dir.glob(@rails_dir + '/*'),@temp_rails, :remove_destination => true)
            @temp_rails = @temp_rails + '/TestRails'
            FileUtils.cp(@database_dir + '/change.sqlite3',@temp_rails + '/db/development.sqlite3')
            options = {:rails_dir => @temp_rails, :model => 'Rails', :template => 'MasterSlave' }
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
            FileUtils.rm_rf(@temp_rails)
          end

          describe "@template_controller.execute_template()" do

            before(:each) do
              @template_controller.execute_template()
            end

            it "should create '*create_column.rb' file" do
              Dir.glob(@migration_dir + "/*change_column_set.rb").empty?().should be_false
            end

            it "should create 'skills_controller.rb' file" do
              Dir.glob(@controller_dir + "/skills_controller.rb").empty?().should be_false
            end

            it "should create 'skills/_form.html.erb' file" do
              Dir.glob(@view_dir + "/skills/_form.html.erb").empty?().should be_false
            end

            it "should create 'skills/_show.html.erb' file" do
              Dir.glob(@view_dir + "/skills/_show.html.erb").empty?().should be_false
            end

            it "should create 'skills/_index.html.erb' file" do
              Dir.glob(@view_dir + "/skills/_index.html.erb").empty?().should be_false
            end

            it "should create 'layouts/index.html.erb' file" do
              Dir.glob(@view_dir + "/layouts/index.html.erb").empty?().should be_false
            end

            it "should have 'routes.rb' file" do
              Dir.glob(@config_dir + "/routes.rb").empty?().should be_false
            end

            it "should contain 'ROUTES' in 'routes.rb' file" do
              route_file = @config_dir + "/routes.rb"
              if File.exists?(route_file)
                file = File.open(route_file,'r')
                contents=file.read()
                file.close()
                contents.should_not be_nil
                contents.length.should > 0
                contents.include?('ROUTES').should be_true
              end              
              Dir.glob(@config_dir + "/routes.rb").empty?().should be_false
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
