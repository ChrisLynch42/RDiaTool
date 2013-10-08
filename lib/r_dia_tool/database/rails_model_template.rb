require 'i_basic_template'

module RDiaTool
  module Database

    class RailsModelTemplate
      include IBasicTemplate

      attr_reader :target_directory, :database_difference


      def initialize(database_difference,options)
        @database_difference=database_difference

        @base_directory = File.dirname(__FILE__) + "/RailsModel"
        @migrate_directory = options[:rails_dir] + "/db/migrate" 
        unless FileTest::directory?(@migrate_directory)
          Dir::mkdir(@migrate_directory)
        end        
        @model_directory = options[:rails_dir] + "/app/models"

        if @database_difference.change().nil?
          raise "@database_difference.change() is nil"
        end 

      end

      def generate
        creations = @database_difference.create()
        unless creations.nil? || creations.length <  1
          creations.each do | key, change |
            template_variables = { 'table_name' => key, 'table_change' => change, 'database' => @database_difference.database }
            Dir.glob(@base_directory + "/migration*create.erb").each do | file_name |
              current_date = Time.now().strftime("%Y%m%d%H")
              run_erb(file_name,current_date + ' _create_' + key + '.rb', template_variables,@migrate_directory)
            end 
            modify_models(key,change, template_variables)           
          end

        end
        changes = @database_difference.change()
        unless changes.nil? || changes.length <  1
          changes.each do | table_name, table_change |
            unless (table_change.add().nil?  || table_change.add().length < 1) && (table_change.remove().nil?  || table_change.remove().length < 1)
              template_variables = { 'table_name' => table_name, 'table_change' => table_change, 'database' => @database_difference.database  }
              Dir.glob(@base_directory + "/migration*change.erb").each do | file_name |
                current_date = Time.now().strftime("%Y%m%d%H")
                run_erb(file_name,current_date + ' _change_' + table_name + '.rb', template_variables,@migrate_directory)
              end
              modify_models(table_name,table_change, template_variables)           
            end
          end
        end
      end

      def modify_models(table_name, table_change, template_variables)
        model_file_name = table_name + ".rb"
        if File.exist?(@model_directory + "/" + model_file_name)
          Dir.glob(@base_directory + "/model_change.erb").each do | file_name |
            change = erb_output(file_name,template_variables)
            existing_content = load_template(@model_directory + '/' + table_name + '.rb')
            existing_content.sub!(/^\s*###Do not edit the below.*###Do not edit the above[ \S]*$/m,change)
            write_template_results(@model_directory + '/' + table_name + '.rb',existing_content)
          end
        else
          Dir.glob(@base_directory + "/model_create.erb").each do | file_name |
            run_erb(file_name, table_name + '.rb', template_variables,@model_directory)
          end
        end
      end

    end
  end
end
