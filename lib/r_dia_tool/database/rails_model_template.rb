module RDiaTool
  module Database

    class RailsModelTemplate

      attr_reader :target_directory, :database_difference

      def generate
        creations = @database_difference.create()
        unless creations.nil? || creations.length <  1
          Dir.glob(@base_directory + "/*model_create.erb").each { | file_name |
            current_date = Time.now().strftime("%Y%m%d%H")
            run_erb(file_name,'tables_create_command_line_' + current_date + '.sh')
          }
        end
        changes = @database_difference.change()
        unless changes.nil? || changes.length <  1
          changes.each { | table_name, table_change |
            unless (table_change.add().nil?  || table_change.add().length < 1) && (table_change.remove().nil?  || table_change.remove().length < 1)
              Dir.glob(@base_directory + "/*model_change.erb").each { | file_name |
                current_date = Time.now().strftime("%Y%m%d%H")
                run_erb(file_name,'tables_add_remove_command_line_' + current_date + '.sh')
              }
              break
            end
          }
          changes.each { | table_name, table_change |
            unless table_change.modify().nil?  || table_change.modify().length < 1
              template_variables=Hash.new()
              template_variables['table_name']=table_name
              template_variables['table_change']=table_change
              Dir.glob(@base_directory + "/*migration_change.erb").each { | file_name |
                current_date = Time.now().strftime("%Y%m%d%H")
                run_erb(file_name,'tables_migration_change_' + table_name + '_'+ current_date + '.sh',template_variables)
              }
            end
          }
        end
      end

      def initialize(database_difference,options)
        @database_difference=database_difference

        @target_directory=options[:target_dir]
        @base_directory = File.dirname(__FILE__) + "/RailsModel"
        if @database_difference.change().nil?
          raise "@database_difference.change() is nil"
        end 
      end

      private

      def run_erb(template_name,target_name,template_variables=Hash.new())
        template_content = load_template(template_name)
        template = ERB.new(template_content)
        template_results = template.result(binding)
        write_template_results(@target_directory + '/' + target_name,template_results)         
      end

      def load_template(template_name)
        if File.exists?(template_name)
          file = File.open(template_name)
          contents=file.read()
        end
      end

      def write_template_results(file_name,template_results)
        File.open(file_name,'w') { |file|
          file.write(template_results)
        }
      end        

    end
  end
end
