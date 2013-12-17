module RDiaLib
  module Database

    class DatabaseChange
      attr_accessor :add, :remove, :modify, :table

      def initialize()
        @add = Hash.new()
        @remove = Hash.new()
        @modify = Hash.new()
      end

    end
  end
end
