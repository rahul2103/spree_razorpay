module Razorpay
  module RpOrder
    class Api < Razorpay::Base
      attr_reader :order

      def create(order_id)
        @order = Spree::Order.find_by(id: order_id)

        razorpay_order = Razorpay::Order.create(order_create_params)

        return razorpay_order.id if razorpay_order.try(:id).present?

        ''
      rescue StandardError
        ''
      end

      private

      def order_create_params
        {
          "amount": order.inr_amt_in_paise,
          "currency": order.currency,
          "receipt": order.number
        }
      end
    end
  end
end
