require 'i_basic_template'
require 'comment_helper'
require 'table_logical_type_enum'

module RDiaTool
  module Database

    class RailsMasterSlaveTemplate
      include IBasicTemplate
      include CommentHelper

        attr_reader :database_difference, :field_templates

      def initialize(database_difference,options)
        @config_directory = options[:rails_dir] + "/config"
        @controller_directory = options[:rails_dir] + "/app/controllers"
        @view_directory = options[:rails_dir] + "/app/views"
        @base_directory = File.dirname(__FILE__) + "/RailsMasterSlave"
        @database_difference=database_difference
        @field_templates = { 'INTEGER' => 'number_field.erb', 
                             'NUMBER' => 'number_field.erb', 
                             'FLOAT' => 'number_field.erb', 
                             'DECIMAL' => 'number_field.erb', 
                             'STRING' => 'text_field.erb', 
                             'BOOLEAN' => 'checkbox_field.erb', 
                             'TEXT' => 'text_area.erb' }
      end

      def generate
        @database_difference.database.tables_by_name.each do | table_name, table_object |
          unless table_object.type == TableLogicalTypeEnum::LINKING
            modify_controller(table_name)
            create_views(table_name)
          end
        end
        create_layouts()
        create_routes()
      end

      private

      def create_routes()
        template_variables = Hash.new()
        template_variables['database']=@database_difference.database        
        routes_section_template_name = "routes.rb.erb"
        routes_name = "routes.rb"
        routes_path = @config_directory + "/" + routes_name

        if File.exist?(routes_path)
          section_content = get_template_results(routes_section_template_name,template_variables)
          content = load_template(routes_path)
          unless content.nil? || section_content.nil?
            re = /^\s*#{prepare_comment_above('ROUTES')}.*#{prepare_comment_below('ROUTES')}[ \S]*$\n/m
            unless content.index(re).nil?              
              content.sub!(re,section_content)
            else
              re = /^.*\.routes\.draw\s+do\s*\n/
              unless content.index(re).nil?
                match = content.match(re)
                section_content = match.to_s + "\n\n" + section_content
                content.sub!(re,section_content)
              end
            end
          end
        else
          content = erb_output(@base_directory + "/routes_master.rb.erb",template_variables)
        end
        if !content.nil? && content.length > 0
          write_template_results(routes_path,content)        
        end
      end

      def create_layouts()
        template_variables = Hash.new()
        template_variables['database']=@database_difference.database
        Dir.glob(@base_directory + "/layouts/*").each do | file_name |
          FileUtils.cp(file_name,@view_directory + "/layouts", :preserve => true)
        end
        content = erb_output(@base_directory + "/application.html.erb",template_variables)
        write_template_results(@view_directory + "/layouts/application.html.erb",content)        
      end

      def create_views(table_name)
        template_variables = Hash.new()
        template_variables['single'] = table_name.downcase.singularize
        template_variables['cap_single'] = table_name.singularize.capitalize
        template_variables['plural'] = table_name.downcase
        template_variables['cap_plural'] = table_name.downcase.capitalize
        template_variables['table_name']=table_name
        template_variables['database']=@database_difference.database
        create_form(table_name, 'form.html.erb',template_variables)
        create_view(table_name, 'show.html.erb',template_variables)
        create_view(table_name, 'index.html.erb',template_variables)
      end

      def create_view(table_name, template_name, template_variables)
        view_sub_directory = get_view_sub_directory(table_name)
        full_view_template_name = "#{@base_directory}/#{template_name}"
        full_view_target_name = "#{view_sub_directory}/_#{template_name}"
        unless File.exist?(full_view_target_name)
          table_object = @database_difference.database.tables_by_name[table_name]
          columns = table_object.columns_in_order
          template_variables['columns']=columns
          content = erb_output(full_view_template_name,template_variables)
          write_template_results(full_view_target_name,content)        
        end       
      end

      def create_form(table_name, template_name, template_variables)
        view_sub_directory = get_view_sub_directory(table_name)
        full_view_template_name = "#{@base_directory}/#{template_name}"
        full_view_target_name = "#{view_sub_directory}/_#{template_name}"
        unless File.exist?(full_view_target_name)
          table_object = @database_difference.database.tables_by_name[table_name]
          columns = table_object.columns_in_order
          column_content = ""
          columns.each { | column | 
            template_name = @field_templates[column.data_type.upcase]
            template_variables['column']=column 
            template_variables['column_name']=column.name
            column_content << erb_output(@base_directory + "/#{template_name}",template_variables)
          }
          template_variables['column_content']=column_content
          content = erb_output(full_view_template_name,template_variables)
          write_template_results(full_view_target_name,content)        
        end       
      end

      def get_view_sub_directory(table_name)
        view_sub_directory_name = table_name.downcase
        view_sub_directory = @view_directory + "/#{view_sub_directory_name}"
        unless File.directory?(view_sub_directory)
          FileUtils.mkdir(view_sub_directory)          
        end
        view_sub_directory
      end


      def modify_controller(table_name)
        controller_file_name = table_name.downcase + "_controller.rb"
        template_variables = Hash.new()
        template_variables['single'] = table_name.downcase.singularize
        template_variables['cap_single'] = table_name.singularize.capitalize
        template_variables['plural'] = table_name.downcase
        template_variables['cap_plural'] = table_name.downcase.capitalize
        template_variables['table_name']=table_name

        if File.exist?(@controller_directory + "/" + controller_file_name)
          content = load_template(@controller_directory + '/' + controller_file_name)
          modify_controller_section(content,'index',template_variables)
          modify_controller_section(content,'show',template_variables)
          modify_controller_section(content,'edit',template_variables)
          modify_controller_section(content,'new',template_variables)
          modify_controller_section(content,'create',template_variables)
          modify_controller_section(content,'update',template_variables)
          modify_controller_section(content,'destroy',template_variables)
        else
          content = erb_output(@base_directory + "/controller_master.erb",template_variables)
        end
        write_template_results(@controller_directory + '/' + controller_file_name,content)        
      end


      def modify_controller_section(content,section,template_variables)
        if content.nil? || content.strip().length < 1
          raise "Empty content!"
        end

        template_name_prepare = "controller_#{section.downcase}_prepare.erb"
        template_name_send = "controller_#{section.downcase}_send.erb"
        prepare_content = get_template_results(template_name_prepare,template_variables)
        send_content = get_template_results(template_name_send,template_variables)
        unless prepare_content.nil?
          re = /^\s*#{prepare_comment_above('PREPARE ' + section.upcase)}.*#{prepare_comment_below('PREPARE ' + section.upcase)}[ \S]*$\n/m
          unless content.index(re).nil?
            content.sub!(re,prepare_content)
          end
        end
        unless send_content.nil?
          re = /^\s*#{prepare_comment_above('SEND ' + section.upcase)}.*#{prepare_comment_below('SEND ' + section.upcase)}[ \S]*$\n/m
          unless content.index(re).nil?
            content.sub!(re,send_content)
          end
        end        
      end

      def get_template_results(template_name,template_variables)
        return_value = nil
        Dir.glob(@base_directory + "/#{template_name}").each do | file_name |
          return_value = erb_output(file_name,template_variables)
        end
        return_value
      end
    end
  end
end
