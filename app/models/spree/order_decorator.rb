module Spree
  module OrderDecorator
    def inr_amt_in_paise
      (amount.to_f * 100).to_i
    end

    def razor_payment(payment_object, payment_method, razorpay_signature)
      payments.create!(
        source: Spree::RazorpayCheckout.create!(
          order_id: id,
          razorpay_payment_id: payment_object.id,
          razorpay_order_id: payment_object.order_id,
          razorpay_signature: razorpay_signature,
          status: payment_object.status,
          payment_method: payment_object.method,
          card_id: payment_object.card_id,
          bank: payment_object.bank,
          wallet: payment_object.wallet,
          vpa: payment_object.vpa,
          email: payment_object.email,
          contact: payment_object.contact
        ),
        payment_method: payment_method,
        amount: total,
        response_code: payment_object.status
      )
    end

    ::Spree::Order.prepend self
  end
end
