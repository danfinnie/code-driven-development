module CodeDrivenDevelopment
  module Rule
    class Class < AbstractRule
      def capable?
        code.sexp_type == :class
      end

      def to_ruby_string
        "describe #{class_name}\n" + recurse(class_body) + "\nend"
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
