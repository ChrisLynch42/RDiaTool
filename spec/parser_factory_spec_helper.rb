
shared_examples_for "Parser Object" do | test_parser |

  describe "Dynamically created parser" do

    it " should not be nil" do
      test_parser.should_not be_nil
    end

  end

end
