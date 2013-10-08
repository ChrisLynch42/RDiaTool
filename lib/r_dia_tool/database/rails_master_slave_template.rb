require 'i_basic_template'

module RDiaTool
  module Database

    class RailsMasterSlaveTemplate
      include IBasicTemplate



      def initialize(database_difference,options)
        @controller_directory = options[:rails_dir] + "/app/controllers"
        @view_directory = options[:rails_dir] + "/app/views"
        @base_directory = File.dirname(__FILE__) + "/RailsMasterSlave"
      end

      private

    end
  end
end
