module CodeDrivenDevelopment
  module Rule
    class MethodCall < AbstractRule
      def capable?
        code.sexp_type == :call &&
          stubber.method_name != :validate &&
          (stubber.receiver_type.nil? || stubber.receiver_type == :const)
      end

      def test
        test_context.befores << "allow(#{stubber.receiver_value}).to receive :#{stubber.method_name}"
        body = [
          "subject",
          "expect(#{stubber.receiver_value}).to have_received :#{stubber.method_name}"
        ]
        test_context << TestComponent::Test.new("calls #{stubber.receiver_and_call}", body)
      end

      private

      def stubber
        @stubber ||= Stubber::Stubber.new(code)
      end
    end
  end
end
