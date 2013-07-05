module RDiaTool
  module Database

    class TemplateController
      attr_reader :template, :dia_xml, :database_configuration_file

      def initialize(template,dia_xml,database_configuration_file)
        @template=template
        @dia_xml=dia_xml
        @database_configuration_file=database_configuration_file
      end

    end
  end
end
