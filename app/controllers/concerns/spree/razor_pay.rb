module Spree
  module RazorPay
    extend ActiveSupport::Concern

    def update_razorpay_checkout
      razorpay_checkout = Spree::RazorpayCheckout.find_or_initialize_by(order_id: order.try(:id))
      razorpay_checkout.update_columns(update_razorpay_response)
    end

    def update_razorpay_response
      {
        razorpay_payment_id: params['razorpay_payment_id'],
        razorpay_order_id: params['razorpay_order_id'],
        razorpay_signature: params['razorpay_signature']
      }
    end
  end
end
