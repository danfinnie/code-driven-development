module CodeDrivenDevelopment
  module Rule
    class AbstractRule
      def initialize(code, ruleset, test_context)
        @code = code
        @ruleset = ruleset
        @test_context = test_context
      end

      def capable?
        raise NotImplementedError.new("#{self.class} doesn't yet implement capable?!")
      end

      def test
        raise NotImplementedError.new("#{self.class} doesn't yet implement test!")
      end

      private

      attr_reader :code, :ruleset, :test_context

      def recurse body, child_test_context
        body.each do |line|
          ruleset.test_for(line, child_test_context)
        end
      end
    end
  end
end
