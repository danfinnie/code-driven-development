module CodeDrivenDevelopment
  module Rule
    class InstanceMethod < AbstractRule
      def capable?
        code.sexp_type == :defn
      end

      def test
        $omgbad = method_name
        new_context = TestComponent::Context.new("##{method_name}")
        recurse(method_body, new_context)
        test_context << new_context
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
