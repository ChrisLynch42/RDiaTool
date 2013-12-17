require 'spec_helper'


describe RDiaLib::Database::ParserClassFactory do

  databaseParserFactory = RDiaLib::Database::ParserClassFactory.new()



  it "should not be 'nil'" do
    databaseParserFactory.should_not == nil
  end

  RDiaLib::Database::TypeEnum.constants.each { | parser_type |
    databaseParserFactory.parser_types[RDiaLib::Database::TypeEnum.const_get(parser_type)].each { | parser_part |
      test_parser = databaseParserFactory.parser(RDiaLib::Database::TypeEnum.const_get(parser_type))
      it_should_behave_like "Parser Object", test_parser

    }

  }  

end
