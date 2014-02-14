module CodeDrivenDevelopment
  module Rule
    class MethodCall < AbstractRule
      def capable?
        code.sexp_type == :call &&
          stubber.method_name != :validate
      end

      def test
        test_context.doubles.concat(stubber.doubles.map { |sym| TestComponent::Double.new(sym) })
        test_context.befores.concat(stubber.befores)
        test_context << TestComponent::Test.new("calls #{stubber.human_name}", ["subject"] + stubber.body)
      end

      private

      def stubber
        @stubber ||= Stubber::Stubber.new(code)
      end
    end
  end
end
