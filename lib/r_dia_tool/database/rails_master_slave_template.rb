require 'i_basic_template'
require 'comment_helper'

module RDiaTool
  module Database

    class RailsMasterSlaveTemplate
      include IBasicTemplate
      include CommentHelper

        attr_reader :database_difference

      def initialize(database_difference,options)
        @controller_directory = options[:rails_dir] + "/app/controllers"
        @view_directory = options[:rails_dir] + "/app/views"
        @base_directory = File.dirname(__FILE__) + "/RailsMasterSlave"
        @database_difference=database_difference
      end
      def generate
        @database_difference.database.tables_by_name.each do | table_name, table_object |
          modify_controller(table_name)
        end
      end

      private


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
