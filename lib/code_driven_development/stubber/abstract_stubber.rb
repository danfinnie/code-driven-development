module CodeDrivenDevelopment
  module Stubber
    class AbstractStubber
      def initialize(sexp)
        @sexp = sexp
      end

      def method_name
        sexp[2]
      end

      def befores
        [
          "allow(#{receiver_value}).to receive(:#{method_name}).and_return(#{method_name})"
        ]
      end

      def doubles
        [
          method_name.to_sym
        ]
      end

      def body
        [
          "expect(#{receiver_value}).to have_received :#{method_name}"
        ]
      end

      private

      attr_reader :sexp

      def receiver
        sexp[1]
      end
    end
  end
end
