
module RDiaTool
  module Database
    class ObjectBuilder
      attr_accessor :tables, :references


      def initialize(document)
        self.tables=Hash.new()
        self.references=Hash.new()
        parse(document)
      end


      private
      def parse(document)

      end

    end
  end
end
