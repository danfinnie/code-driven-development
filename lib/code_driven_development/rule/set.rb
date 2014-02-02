module CodeDrivenDevelopment
  module Rule
    class Set
      attr_reader :output

      def initialize(*rules, default: nil, output: nil)
        @rules = rules
        @default_rule = default
        @output = output
      end

      def test_for(code)
        capable_rules = @rules.map do |klass|
          klass.new(code, self)
        end.select(&:capable?)

        case capable_rules.count
        when 0
          @default_rule.new(code, self).test
        when 1
          capable_rules.first.test
        else
          raise "Multiple rules matched #{code.inspect}:\n\t" + capable_rules.map(&:class).map(&:to_s).join("\n\t")
        end
      end
    end
  end
end
