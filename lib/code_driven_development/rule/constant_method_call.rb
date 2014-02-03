module CodeDrivenDevelopment
  module Rule
    class ConstantMethodCall < AbstractRule
      def capable?
        code.sexp_type == :call &&
          method_name != :validate &&
          receiver_type == :const
      end

      def test
        test_context.befores << "allow(#{receiver_value}).to receive :#{method_name}"
        body = ["expect(#{receiver_value}).to have_received :#{method_name}"]
        test_context << TestComponent::Test.new("calls #{receiver_value}.#{method_name}", body)
      end

      private

      def receiver_value
        receiver.value
      end

      def receiver_type
        receiver && receiver.sexp_type
      end

      def receiver
        code[1]
      end

      def method_name
        code[2]
      end
    end
  end
end
