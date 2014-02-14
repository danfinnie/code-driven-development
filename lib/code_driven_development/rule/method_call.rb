module CodeDrivenDevelopment
  module Rule
    class MethodCall < AbstractRule
      def capable?
        code.sexp_type == :call &&
          method_name != :validate &&
          (receiver_type.nil? || receiver_type == :const)
      end

      def test
        test_context.befores << "allow(#{receiver_value}).to receive :#{method_name}"
        body = [
          "subject",
          "expect(#{receiver_value}).to have_received :#{method_name}"
        ]
        test_context << TestComponent::Test.new("calls #{receiver_and_call}", body)
      end

      private

      def receiver_value
        receiver_type.nil? ? "obj" : receiver.value
      end

      def receiver_type
        receiver && receiver.sexp_type
      end

      def receiver_and_call
        receiver_type.nil? ? "##{method_name}" : "#{receiver_value}.#{method_name}"
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
