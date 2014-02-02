module CodeDrivenDevelopment
  module Rule
    class MethodCall < AbstractRule
      def capable?
        code.sexp_type == :call &&
          method_name != :validate
      end

      def test
        test_context.befores << "allow(#{receiver}).to receive :#{method_name}"
        body = ["expect(#{receiver}).to have_received :#{method_name}"]
        test_context << TestComponent::Test.new("calls #{receiver}.#{method_name}", body)
      end

      private

      def receiver
        code[1].value
      end

      def method_name
        code[2]
      end
    end
  end
end
