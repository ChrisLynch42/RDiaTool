module RDiaTool
  module Database

    class RailsModelContinuousTemplate < RailsModelTemplate

      def generate
        creations = @database_difference.create()
        unless creations.nil? || creations.length <  1
          creations.each do | key, change |
            template_variables = { 'table_name' => key, 'table_change' => change, 'database' => @database_difference.database }
            Dir.glob(@base_directory + "/migration*create.erb").each do | file_name |
              current_date = Time.now().strftime("%Y%m%d%H")
              run_erb(file_name,current_date + ' _create_' + key + '.rb', template_variables,@migrate_directory)
            end
            Dir.glob(@base_directory + "/model*create.erb").each do | file_name |
              run_erb(file_name, key + '.rb', template_variables,@model_directory)
            end            
          end

        end
        changes = @database_difference.change()
        unless changes.nil? || changes.length <  1
          changes.each do | table_name, table_change |
            unless (table_change.add().nil?  || table_change.add().length < 1) && (table_change.remove().nil?  || table_change.remove().length < 1)
              template_variables = { 'table_name' => table_name, 'table_change' => table_change }
              Dir.glob(@base_directory + "/migration*change.erb").each do | file_name |
                current_date = Time.now().strftime("%Y%m%d%H")
                run_erb(file_name,current_date + ' _change_' + table_name + '.rb', template_variables,@migrate_directory)
              end
            end
          end
        end
      end

      def initialize(database_difference,options)
        super(database_difference,options)
        @migrate_directory = options[:rails_dir] + "/db/migrate"
        @model_directory = options[:rails_dir] + "/app/models"
        unless FileTest::directory?(@migrate_directory)
          Dir::mkdir(@migrate_directory)
        end        
        @base_directory = File.dirname(__FILE__) + "/RailsModelContinuous"        
      end

      private

    end
  end
end
