module Razorpay
  class Base
    def initialize
      setup_razorpay
    end

    private

    def find_payment_gateway
      Spree::PaymentMethod.find_by(type: 'Spree::Gateway::RazorpayGateway')
    end

    def setup_razorpay
      find_payment_gateway.provider
    end
  end
end
