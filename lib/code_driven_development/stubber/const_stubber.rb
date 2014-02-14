module CodeDrivenDevelopment
  module Stubber
    class ConstStubber
      def initialize(sexp)
        @sexp = sexp
      end

      def receiver_value
        receiver.value
      end

      def receiver_and_call
        "#{receiver_value}.#{method_name}"
      end

      def method_name
        sexp[2]
      end

      private

      attr_reader :sexp

      def receiver
        sexp[1]
      end
    end
  end
end
