module RDiaTool
  module Database

    class RailsModelTemplate
      attr_reader :database_difference, :target_directory

      def generate
        creations = @database_difference.create()
        creations.each { | table_name, table_create |
          unless table_create.nil?
            unless table_create.add().nil?
              Dir.glob(@base_directory + "/*create.erb").each { | file_name |
                puts 'in the glob'
                puts file_name
                run_erb(file_name,table_name + '_create.sh')
              }
            end
            #implement calling ERB Template
          end
        }
      end

      def initialize(database_difference,target_directory)        
        @database_difference=database_difference
        @target_directory=target_directory
        @base_directory = base_dir=File.dirname(__FILE__) + "/RailsModel"
        if @database_difference.nil?
          raise "@database_difference is nil"
        elsif @database_difference.class.name == 'RDiaTool\:\:Database\:\:DatabaseDifference'
          raise "@database_difference is of the wrong class type: " + @database_difference.class.name
        end
        if @database_difference.change().nil?
          raise "@database_difference.change() is nil"
        end 
      end

      private

        def run_erb(template_name,target_name)
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
