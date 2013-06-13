require 'nokogiri'
require 'i_basic_template'

module RDiaTool
  module Database
    class MeteorTemplate
      include IBasicTemplate

      def initialize() 
        self.directories = ['client','server','public']
        self.templates = [BasicTemplateFile.new('server','bootstrap.js'),BasicTemplateFile.new('server','publish.js')]
      end      


      def generate() 
        create_directories()
      end

      private
        def create_directories()
          if !self.directories.nil? && self.directories.kind_of?(Array)
            self.directories.each() { |directory| 
              FileUtils.mkdir_p(self.base_directory + "/" + directory)
            }
          end
        end

        def create_templates()          
          if !self.templates.nil? && self.templates.kind_of?(Array)
            self.templates.each() { |template| 

            }
          end
        end

    end
  end
end
