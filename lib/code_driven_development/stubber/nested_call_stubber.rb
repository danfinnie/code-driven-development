module CodeDrivenDevelopment
  module Stubber
    class NestedCallStubber < AbstractStubber
      def receiver_value
        receiver[2]
      end

      def human_name
        "#{substubber.human_name}.#{method_name}"
      end

      def befores
        substubber.befores << "allow(#{substubber.method_name}).to receive(:#{method_name}).and_return(#{method_name})"
      end

      def body
        substubber.body << "expect(#{substubber.method_name}).to have_received :#{method_name}"
      end

      def doubles
        substubber.doubles << method_name.to_sym
      end

      private

      def substubber
        @substubber ||= Stubber.new(receiver)
      end
    end
  end
end
