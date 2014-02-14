module CodeDrivenDevelopment
  module Stubber
    class Stubber
      def self.new(sexp)
        raise "That's not a call!" unless sexp.sexp_type == :call

        receiver = sexp[1] && sexp[1].sexp_type

        case receiver
        when nil
          InstanceMethodStubber.new(sexp)
        when :const
          ConstStubber.new(sexp)
        when :call
          NestedCallStubber.new(sexp)
        else
          raise "Can't stub #{receiver.inspect} :("
        end
      end
    end
  end
end
