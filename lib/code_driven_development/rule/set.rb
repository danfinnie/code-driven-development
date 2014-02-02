module CodeDrivenDevelopment
  module Rule
    class Set
      def initialize(*rules, default: nil)
        @rules = rules
        @default_rule = default
      end

      def to_ruby_string(code)
        capable_rules = @rules.map do |klass|
          klass.new(code, self)
        end.select(&:capable?)

        case capable_rules.count
        when 0
          @default_rule.new(code, self).to_ruby_string
        when 1
          capable_rules.first.to_ruby_string
        else
          raise "Multiple rules matched #{code.inspect}:\n\t" + capable_rules.map(&:class).map(&:to_s).join("\n\t")
        end
      end
    end
  end
end
