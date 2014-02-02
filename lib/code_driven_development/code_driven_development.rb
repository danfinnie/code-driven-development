module CodeDrivenDevelopment
  class CodeDrivenDevelopment
    def initialize(implementation)
      @implementation = implementation
    end

    def test_code
      ruleset.to_ruby_string(parse_tree)
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
        default: Rule::Default
      )
    end
  end
end
