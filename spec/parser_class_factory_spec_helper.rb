shared_examples_for "Parser Object" do | test_parser |

  describe "Dynamically created parser" do
    describe "Class" do

      it " should not be nil" do
        test_parser.should_not be_nil
      end
    end

    describe "Instance" do

      before(:each) do
        @test_parser_object = test_parser.new()
      end

      it "should have a parse method" do
        @test_parser_object.methods(true).include?(:parse).should be_true      
      end
    end
  end
end
