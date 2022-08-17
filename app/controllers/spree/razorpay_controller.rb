module Spree
  class RazorpayController < StoreController
    skip_before_action :verify_authenticity_token
    before_action :provider, only: [:response]

    def response
      debugger

      rp_fetch = Razorpay::Payment.fetch(params['razorpay_payment_id'])

      debugger

    end

    private

    def payment_method
      Spree::PaymentMethod.find(params[:payment_method_id])
    end

    def provider
      payment_method.provider
    end
  end
end
