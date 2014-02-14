module CodeDrivenDevelopment
  module Stubber
    class InstanceMethodStubber < AbstractStubber
      def receiver_value
        "obj"
      end

      def human_name
        method_name.to_s
      end
    end
  end
end
