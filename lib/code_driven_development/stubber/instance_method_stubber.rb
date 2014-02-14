module CodeDrivenDevelopment
  module Stubber
    class InstanceMethodStubber < AbstractStubber
      def receiver_value
        "obj"
      end

      def human_name
        "##{method_name}"
      end
    end
  end
end
