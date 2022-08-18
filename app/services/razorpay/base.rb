module Razorpay
  class Base
    attr_reader :payment_method

    def initialize
      @payment_method = Spree::PaymentMethod.find_by_type('Spree::Gateway::RazorpayGateway')
      setup_razorpay
    end

    private

    def setup_razorpay
      payment_method.provider
    end
  end
end