module CodeDrivenDevelopment
  module Rule
    class InstanceMethod < AbstractRule
      def capable?
        code.sexp_type == :defn
      end

      def to_ruby_string
        %Q(describe "##{method_name}" do\n") + recurse(method_body) + "\nend"
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
