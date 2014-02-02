module CodeDrivenDevelopment
  module Rule
    class InstanceMethod < AbstractRule
      def capable?
        code.sexp_type == :defn
      end

      def to_ruby_string
        ruleset.output << %Q(describe "##{method_name}" do)
        $omgbad = method_name
        ruleset.output.indented do
          recurse(method_body)
        end
        ruleset.output << "end"
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
