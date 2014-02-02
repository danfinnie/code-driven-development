module CodeDrivenDevelopment
  class CodeDrivenDevelopment
    def initialize(implementation)
      @implementation = implementation
    end

    def test_code
      ruleset.test_for(parse_tree).to_s
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
        Rule::MethodCall,
        default: Rule::Default,
        output: IndentedOutput.new
      )
    end
  end
end
