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
        parse_references(document)
      end

      def parse_references(document)
        reference_nodes =document.xpath("//dia:object[@type='Database - Reference']")
        if !reference_nodes.nil?
          parser_factory = ParserFactory.new()        
          reference_nodes.each do | reference_node |
            reference_parser = parser_factory.parser(REFERENCE)
            reference_parser_object=reference_parser.new()
            reference_parser_object.parse(reference_node)
            self.references[reference_parser_object.object_id] =  reference_parser_object
          end
        end

      end

      def parse_tables(document)
        table_nodes =document.xpath("//dia:object[@type='Database - Table']")
        if !table_nodes.nil?
          parser_factory = ParserFactory.new()        
          table_nodes.each do | table_node |
            table_parser = parser_factory.parser(TABLE)
            table_parser_object=table_parser.new()
            table_parser_object.parse(table_node)
            self.tables[table_parser_object.object_id] =  table_parser_object
          end
        end

      end

    end
  end
end
