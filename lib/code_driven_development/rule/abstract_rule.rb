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

      def test
        raise NotImplementedError.new("#{self.class} doesn't yet implement test!")
      end

      private

      attr_reader :code, :ruleset

      def recurse body
        body.map do |line|
          ruleset.test_for(line)
        end.join("\n")
      end
    end
  end
end
