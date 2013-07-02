require 'parser_factory'

module RDiaTool
  module Database
    class ObjectBuilder
      include RDiaTool::Database::TypeEnum
      
      attr_accessor :tables, :references


      def initialize(document)
        self.tables=Hash.new()
        self.references=Hash.new()
        parse(document)
      end


      private
      def parse(document)
        parse_tables(document)
      end

      def parse_tables(document)
        table_nodes =document.xpath("//dia:object[@type='Database - Table']")
        puts 'uyyyyyyyyyyyyyyy'
        puts table_nodes
        if !table_nodes.nil?
          parser_factory = ParserFactory.new()        
          table_nodes.each do | table_node |
            puts 'xxxxxxxxxxxxxxxxxxxxxxxxx'
            table_parser = parser_factory.parser(TABLE)
            table_parser.parse(table_node)
            self.tables[table_parser.object_id] =  table_parser
          end
        end

      end

    end
  end
end
