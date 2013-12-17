require 'nokogiri'
require 'erb'

module RDiaLib
  module Database
    module IBasicTemplate

      attr_accessor :base_directory, :directories, :templates

      

      def generate()

      end


     protected 

      def run_erb(template_name,target_name,template_variables=Hash.new(),destination_dir=nil)
        if destination_dir.nil?
          destination_dir=@target_directory
        end
        write_template_results(destination_dir + '/' + target_name,erb_output(template_name,template_variables))         
      end

      def erb_output(template_name,template_variables=Hash.new())
        template_content = load_template(template_name)
        template = ERB.new(template_content)
        template_results = template.result(binding)
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
