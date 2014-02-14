module CodeDrivenDevelopment
  module Rule
    class MethodCall < AbstractRule
      def capable?
        code.sexp_type == :call &&
          stubber.method_name != :validate
      end

      def test
        test_context.befores << stubber.before
        test_context << TestComponent::Test.new("calls #{stubber.human_name}", stubber.body)
      end

      private

      def stubber
        @stubber ||= Stubber::Stubber.new(code)
      end
    end
  end
end
