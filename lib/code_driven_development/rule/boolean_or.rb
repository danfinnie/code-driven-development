module CodeDrivenDevelopment
  module Rule
    class BooleanOr < AbstractRule
      def capable?
        code.sexp_type == :or &&
          left.sexp_type == :call &&
          right.sexp_type == :call
      end

      def test
        left_stub = Stubber::Stubber.new(left)
        right_stub = Stubber::Stubber.new(right)

        left_is_true_context = TestComponent::Context.new(%Q("##{left_stub.human_name} is truthy"))
        right_is_true_context = TestComponent::Context.new(%Q("##{left_stub.human_name} is falsey"))

        left_is_true_context.befores.concat(left_stub.befores)
        left_is_true_context.befores.concat(right_stub.befores)

        left_is_true_context.doubles.concat(left_stub.doubles)
        left_is_true_context.doubles.concat(right_stub.doubles)

        left_is_true_context << TestComponent::Test.new("returns #{left_stub.human_name}", [
          "expect(subject).to eq '#{left_stub.method_name}'"
        ])

        left_is_true_context << TestComponent::Test.new("doesn't call ##{right_method_name}", [
          "subject",
          "expect(obj).not_to have_received :#{right_method_name}"
        ])

        right_is_true_context.befores << "allow(obj).to receive(:#{left_method_name}).and_return(false)"
        right_is_true_context.befores << "allow(obj).to receive(:#{right_method_name}).and_return('#{right_method_name}')"

        right_is_true_context << TestComponent::Test.new("returns ##{right_method_name}", [
          "expect(subject).to eq '#{right_method_name}'"
        ])

        right_is_true_context << TestComponent::Test.new("calls ##{left_method_name}", [
          "subject",
          "expect(obj).to have_received :#{left_method_name}"
        ])

        test_context << left_is_true_context
        test_context << right_is_true_context
      end

      private

      def left
        code[1]
      end

      def left_method_name
        left[2]
      end

      def right
        code[2]
      end

      def right_method_name
        right[2]
      end
    end
  end
end
