module CodeDrivenDevelopment
  module Rule
    class BooleanOr < AbstractRule
      def capable?
        code.sexp_type == :or &&
          left.sexp_type == :call &&
          right.sexp_type == :call
      end

      def test
        left_is_true_context = TestComponent::Context.new(%Q("##{left_method_name} is truthy"))
        right_is_true_context = TestComponent::Context.new(%Q("##{left_method_name} is falsey"))

        left_is_true_context.befores << "allow(obj).to receive(:#{left_method_name}).and_return('#{left_method_name}')"
        left_is_true_context.befores << "allow(obj).to receive(:#{right_method_name})"

        left_is_true_context << TestComponent::Test.new("returns ##{left_method_name}", [
          "expect(subject).to eq '#{left_method_name}'"
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
