module CodeDrivenDevelopment
  module Stubber
    class ConstStubber < AbstractStubber
      def receiver_value
        receiver.value
      end

      def receiver_and_call
        "#{receiver_value}.#{method_name}"
      end
    end
  end
end
