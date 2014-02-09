module CodeDrivenDevelopment
  module Rule
    class InstanceMethod < AbstractRule
      def capable?
        code.sexp_type == :defn
      end

      def test
        new_context = TestComponent::Context.new(%Q("##{method_name}"))
        recurse(method_body, new_context)
        test_context << new_context

        # Do this last so that the method invocation is the last line in the before.
        new_context.subject = "obj.#{method_name}"
        new_context.lets << TestComponent::Let.new(:obj, "described_class.new")
      end

      private

      def method_name
        code[1]
      end

      def method_body
        code[3..-1]
      end
    end
  end
end
