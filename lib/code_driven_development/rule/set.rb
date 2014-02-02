module CodeDrivenDevelopment
  module Rule
    class Set
      def initialize(*rules, default: nil)
        @rules = rules
        @default_rule = default
      end

      def test_for(code, test_context)
        capable_rules = rules.map do |klass|
          klass.new(code, self, test_context)
        end.select(&:capable?)

        case capable_rules.count
        when 0
          default_rule.new(code, self, test_context).test
        when 1
          capable_rules.first.test
        else
          raise "Multiple rules matched #{code.inspect}:\n\t" + capable_rules.map(&:class).map(&:to_s).join("\n\t")
        end
      end

      private

      attr_reader :rules, :default_rule
    end
  end
end
