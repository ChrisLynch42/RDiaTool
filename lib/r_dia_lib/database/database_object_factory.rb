require 'parser_class_factory'
require 'database_object'

module RDiaLib
  module Database
    class DatabaseObjectFactory 
      include RDiaLib::Database::TypeEnum
      
      attr_reader :dia_xml
 

      def initialize(document)
        @dia_xml=document
        @parser_class_factory = ParserClassFactory.new()
      end

      def database
        @tables_by_name=Hash.new()
        @tables_by_id=Hash.new()
        @references=Hash.new()
        parse()
        @database_object = DatabaseObject.new(@tables_by_name,@tables_by_id,@references)
      end

      def table
        table_class = Class.new()
        table_class.send(:include,ITable)
        table_object = table_class.new()
      end

      def column
        column_class = Class.new()
        column_class.send(:include, IColumn)
        column_object = column_class.new()
      end

      private
      def parse()
        parse_tables()
        parse_references()
      end

      def parse_references()
        reference_nodes =self.dia_xml.xpath("//dia:object[@type='Database - Reference']")
        if !reference_nodes.nil?
                  
          reference_nodes.each do | reference_node |
            reference_parser = @parser_class_factory.parser(REFERENCE)
            reference_parser_object=reference_parser.new()
            reference_parser_object.parse(reference_node)
            if !reference_parser_object.nil?
               @references[reference_parser_object.id] =  reference_parser_object
            end
          end
        end

      end

      def parse_tables()
        table_nodes =self.dia_xml.xpath("//dia:object[@type='Database - Table']")
        if !table_nodes.nil?
          table_nodes.each do | table_node |
            table_parser = @parser_class_factory.parser(TABLE)
            table_parser_object=table_parser.new()
            table_parser_object.parse(table_node)
            if !table_parser_object.nil?
              @tables_by_name[table_parser_object.name] =  table_parser_object
              @tables_by_id[table_parser_object.object_id] =  table_parser_object
            end
          end
        end

      end

    end
  end
end
