module CodeDrivenDevelopment
  module Stubber
    class NestedCallStubber < AbstractStubber
      def receiver_value
        receiver[2]
      end

      def human_name
        "#{receiver_value}.#{method_name}"
      end

      def befores
        [
          "allow(#{receiver_value}).to receive(:#{method_name}).and_return(#{method_name})",
          "allow(obj).to receive(:#{receiver_value}).and_return(#{receiver_value})",
        ]
      end

      def body
        [
          "expect(#{receiver_value}).to have_received :#{method_name}",
          "expect(obj).to have_received :#{receiver_value}",
        ]
      end

      def doubles
        [method_name.to_sym, receiver_value.to_sym]
      end
    end
  end
end
