module CodeDrivenDevelopment
  module Rule
    class Validation < AbstractRule
      def capable?
        code.sexp_type == :call &&
          code.sexp_body[0].nil? &&
          code.sexp_body[1] == :validate
      end

      def test
        test_context << TestComponent::OneLineTest.new("should validate_#{type}_of :#{field}")
      end

      private

      def field
        extract_symbol(code[3])
      end

      def type
        extract_symbol(extract_hash_key(code[-1]))
      end

      def extract_symbol(literal)
        literal[1]
      end

      def extract_hash_key(hash)
        hash[1]
      end
    end
  end
end
