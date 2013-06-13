require 'nokogiri'
require 'i_basic_template'

module RDiaTool
  module Database
    class MeteorTemplate
      include IBasicTemplate

      def initialize() 
        self.directories = ['client','server','public']
      end      


      def generate() 
        build_directories()
      end

      private
        def build_directories()          
          self.directories.each() { |directory| 
            Dir.mkdir(self.base_directory + "/" + directory)
          }
        end

    end
  end
end
