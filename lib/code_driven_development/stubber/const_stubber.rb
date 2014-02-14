module CodeDrivenDevelopment
  module Stubber
    class ConstStubber < AbstractStubber
      def receiver_value
        receiver.value
      end

      def human_name
        "#{receiver_value}.#{method_name}"
      end
    end
  end
end
