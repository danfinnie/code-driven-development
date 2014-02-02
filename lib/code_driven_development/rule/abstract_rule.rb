module CodeDrivenDevelopment
  module Rule
    class AbstractRule
      def initialize(code, ruleset)
        @code = code
        @ruleset = ruleset
      end

      def capable?
        raise NotImplementedError.new("#{self.class} doesn't yet implement capable?!")
      end

      def to_ruby_string
        raise NotImplementedError.new("#{self.class} doesn't yet implement to_ruby_string!")
      end

      private

      attr_reader :code, :ruleset

      def recurse body
        body.map do |line|
          ruleset.to_ruby_string(line)
        end.join("\n")
      end
    end
  end
end
