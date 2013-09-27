require 'i_database_difference'
require 'rails_model_difference'
module RDiaTool
  module Database

    class RailsModelContinuousDifference < RailsModelDifference

      def initialize(dia_xml, options)
        super(dia_xml, options)
      end

    end
  end
end
