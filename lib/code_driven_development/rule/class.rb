module CodeDrivenDevelopment
  module Rule
    class Class < AbstractRule
      def capable?
        code.sexp_type == :class
      end

      def test
        new_context = TestComponent::Context.new(class_name)
        recurse(class_body, new_context)
        test_context << new_context
      end

      private

      def class_body
        code[3..-1]
      end

      def class_name
        code[1]
      end
    end
  end
end
