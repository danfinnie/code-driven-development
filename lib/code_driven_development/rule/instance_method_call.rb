module CodeDrivenDevelopment
  module Rule
    class InstanceMethodCall < AbstractRule
      def capable?
        code.sexp_type == :call &&
          method_name != :validate &&
          receiver_type.nil?
      end

      def test
        test_context.befores << "allow(#{receiver_value}).to receive :#{method_name}"
        body = ["expect(#{receiver_value}).to have_received :#{method_name}"]
        test_context << TestComponent::Test.new("calls ##{method_name}", body)
      end

      private

      def receiver_value
        "obj"
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
