module CodeDrivenDevelopment
  module Stubber
    class InstanceMethodStubber
      def initialize(sexp)
        @sexp = sexp
      end

      def receiver_value
        "obj"
      end

      def receiver_and_call
        "##{method_name}"
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
