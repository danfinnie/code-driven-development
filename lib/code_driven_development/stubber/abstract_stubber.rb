module CodeDrivenDevelopment
  module Stubber
    class AbstractStubber
      def initialize(sexp)
        @sexp = sexp
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
