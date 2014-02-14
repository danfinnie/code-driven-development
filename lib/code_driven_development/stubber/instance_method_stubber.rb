module CodeDrivenDevelopment
  module Stubber
    class InstanceMethodStubber < AbstractStubber
      def receiver_value
        "obj"
      end

      def receiver_and_call
        "##{method_name}"
      end
    end
  end
end
