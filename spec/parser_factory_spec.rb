require 'spec_helper'


describe "Database Parser Factory" do

  databaseParserFactory = RDiaTool::Database::ParserFactory.new()



  it "should not be 'nil'" do
    databaseParserFactory.should_not == nil
  end

  RDiaTool::Database::TypeEnum.constants.each { | parser_type |
    databaseParserFactory.parser_types[RDiaTool::Database::TypeEnum.const_get(parser_type)].each { | parser_part |
      test_parser = databaseParserFactory.parser(RDiaTool::Database::TypeEnum.const_get(parser_type))
      it_should_behave_like "Parser Object", test_parser

    }

  }  

end
