module CodeDrivenDevelopment
  module Stubber
    class Stubber
      def initialize(sexp)
        raise "That's not a call!" unless sexp.sexp_type == :call
        @sexp = sexp
      end

      def receiver_value
        receiver_type.nil? ? "obj" : receiver.value
      end

      def receiver_type
        receiver && receiver.sexp_type
      end

      def receiver_and_call
        receiver_type.nil? ? "##{method_name}" : "#{receiver_value}.#{method_name}"
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
