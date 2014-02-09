module CodeDrivenDevelopment
  class CodeDrivenDevelopment
    def initialize(implementation)
      @implementation = implementation
    end

    def test_code
      test_context = TestComponent::BlankSlate.new
      ruleset.test_for(parse_tree, test_context)
      test_context.indented_output
    end

    private

    attr_reader :implementation

    def parse_tree
      RubyParser.new.parse(implementation)
    end

    def ruleset
      Rule::Set.new(
        Rule::Class,
        Rule::Validation,
        Rule::InstanceMethod,
        Rule::ConstantMethodCall,
        Rule::InstanceMethodCall,
        Rule::BooleanOr,
        default: Rule::Default
      )
    end
  end
end
