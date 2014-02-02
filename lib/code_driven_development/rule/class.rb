module CodeDrivenDevelopment
  module Rule
    class Class < AbstractRule
      def capable?
        code.sexp_type == :class
      end

      def to_ruby_string
        ruleset.output << "describe #{class_name} do"
        ruleset.output.indented do
          recurse(class_body)
        end
        ruleset.output << "end"
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
