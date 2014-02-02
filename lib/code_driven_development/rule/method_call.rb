module CodeDrivenDevelopment
  module Rule
    class MethodCall < AbstractRule
      def capable?
        code.sexp_type == :call &&
          method_name != :validate
      end

      def test
        ruleset.output << %Q(it "calls #{receiver}.#{method_name}" do)
        ruleset.output.indented do
          ruleset.output << "allow(#{receiver}).to receive :#{method_name}"
          ruleset.output << "described_class.new.#{$omgbad}"
          ruleset.output << "expect(#{receiver}).to have_received :#{method_name}"
        end
        ruleset.output << "end"
      end

      private

      def receiver
        code[1].value
      end

      def method_name
        code[2]
      end
    end
  end
end
