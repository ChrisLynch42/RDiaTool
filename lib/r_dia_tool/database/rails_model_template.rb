require 'i_basic_template'

module RDiaTool
  module Database

    class RailsModelTemplate
      include IBasicTemplate

      attr_reader :target_directory, :database_difference, :has_many_through, :has_many, :belongs_to


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
        analyze_references()
        template_variables = { 'has_many_through' => @has_many_through, 'has_many' => @has_many, 'belongs_to' => @belongs_to, 'database' => @database_difference.database }
        creations = @database_difference.create()
        unless creations.nil? || creations.length <  1
          creations.each do | key, change |
            template_variables['table_name'] = key
            template_variables['table_change'] = change
            Dir.glob(@base_directory + "/migration*create.erb").each do | file_name |
              current_date = get_time_marker()
              run_erb(file_name,current_date + '_create_' + key.underscore + '.rb', template_variables,@migrate_directory)
            end 
            modify_models(key,change, template_variables)           
          end

        end
        changes = @database_difference.change()
        unless changes.nil? || changes.length <  1
          changes.each do | table_name, table_change |
            unless (table_change.add().nil?  || table_change.add().length < 1) && (table_change.remove().nil?  || table_change.remove().length < 1)
              template_variables['table_name'] = table_name
              template_variables['table_change'] = table_change
              Dir.glob(@base_directory + "/migration*change.erb").each do | file_name |
                current_date = get_time_marker()
                run_erb(file_name,current_date + '_change_' + table_name.underscore + '.rb', template_variables,@migrate_directory)
              end
              modify_models(table_name,table_change, template_variables)           
            end
          end
        end
      end

      def analyze_references
        @has_many_through = Hash.new()
        @has_many = Hash.new()
        @belongs_to = Hash.new()
        database = @database_difference.database
        database.tables_by_name.each do | table_name, table |
          if table.references.length > 1
            build_has_many_through(table)
          else
            build_has_many(table)
          end
          build_belongs_to(table)
        end
      end

      def build_has_many_through(table)
        table.references.each do | id, reference |
          outer_table = reference.start_point.table_name
          if @has_many_through[outer_table].nil? || !@has_many_through[outer_table].class == Array
            @has_many_through[outer_table] = Array.new()
          end
          table.references.each do | inner_id, inner_reference |
            if inner_id != id
              inner_table = inner_reference.start_point.table_name
              middle_table = inner_reference.end_point.table_name
              @has_many_through[outer_table][@has_many_through[outer_table].length] = "has_many :#{inner_table} through: :#{middle_table}"
            end
          end
        end
      end

      def build_belongs_to(table)
        @belongs_to[table.name] = Array.new()              
        table.references.each do | id, reference |
          many_table = reference.end_point.table_name
          one_table = reference.start_point.table_name
          @belongs_to[many_table][@belongs_to[many_table].length] = "belongs_to :#{one_table}"
        end
      end

      def build_has_many(table)
        table.references.each do | id, reference |
          many_table = reference.end_point.table_name
          one_table = reference.start_point.table_name
          if @has_many[one_table].nil? || !@has_many[one_table].class == Array
            @has_many[one_table] = Array.new()
          end
          @has_many[one_table][@has_many[one_table].length] = "has_many :#{many_table}"
        end
      end      

      def get_time_marker
        Time.now().strftime("%Y%m%d%H%M%S%L%N")
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
