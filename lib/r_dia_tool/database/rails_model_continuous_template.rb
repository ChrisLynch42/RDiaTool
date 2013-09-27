module RDiaTool
  module Database

    class RailsModelContinuousTemplate < RailsModelTemplate

      attr_reader :target_directory, :database_difference

      def generate
        creations = @database_difference.create()
        unless creations.nil? || creations.length <  1
          creations.each do | key, change |
            template_variables = { 'table_name' => key, 'table_change' => change }
            Dir.glob(@base_directory + "/*create.erb").each do | file_name |
              current_date = Time.now().strftime("%Y%m%d%H")
              run_erb(file_name,current_date + ' _create_' + key + '.rb', template_variables)
            end
          end

        end
        changes = @database_difference.change()
        unless changes.nil? || changes.length <  1
          changes.each do | table_name, table_change |
            unless (table_change.add().nil?  || table_change.add().length < 1) && (table_change.remove().nil?  || table_change.remove().length < 1)
              template_variables = { 'table_name' => table_name, 'table_change' => table_change }
              Dir.glob(@base_directory + "/*change.erb").each do | file_name |
                current_date = Time.now().strftime("%Y%m%d%H")
                run_erb(file_name,current_date + ' _change_' + table_name + '.rb', template_variables)
              end
            end
          end
        end
      end

      def initialize(database_difference,target_directory)
        super(database_difference,target_directory)
        @base_directory = File.dirname(__FILE__) + "/RailsModelContinuous"        
      end

      private

    end
  end
end
