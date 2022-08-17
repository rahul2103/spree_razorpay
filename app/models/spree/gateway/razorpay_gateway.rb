require 'razorpay'

module Spree
  class Gateway::RazorpayGateway < Gateway
    preference :key_id, :string
    preference :key_secret, :string
    preference :merchant_name, :string
    preference :merchant_description, :text
    preference :merchant_address, :string
    preference :theme_color, :string, default: '#F37254'

    def supports?(_source)
      true
    end

    def provider_class
      self
    end

    def provider
      Razorpay.setup(
        preferred_key_id,
        preferred_key_secret
      )
    end

    def auto_capture?
      true
    end

    def method_type
      'razorpay'
    end

    def purchase(_amount, _transaction_details, _gateway_options = {})
      ActiveMerchant::Billing::Response.new(true, 'razorpay success')
    end

    def request_type
      'DEFAULT'
    end

    def process_razor_payment(params, order)
      payment_method = self
      # setup_razorpay(payment_method)

      razorpay_pmnt_obj = Razorpay::Payment.fetch(params[:razorpay_payment_id])
      status = razorpay_pmnt_obj.status

      debugger

      payment = payment(order, razorpay_pmnt_obj, payment_method)
      debugger

      if status == "authorized"
        razorpay_pmnt_obj.capture({ amount: order.amount_in_paise })
        razorpay_pmnt_obj = Razorpay::Payment.fetch(params[:razorpay_payment_id])
        payment.update(response_code: razorpay_pmnt_obj.status)
        razorpay_pmnt_obj.status
      else
        debugger

        raise StandardError, 'Unable to capture payment'
      end
    end

    private

    def payment(order, payment_object, payment_method)
      order.payments.create!(
        source: Spree::RazorpayCheckout.create(
          order_id: order.id,
          razorpay_payment_id: payment_object.id,
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
        amount: order.total,
        response_code: payment_object.status
        )
    end

    def amount_in_paise
      (amount.to_f * 100).to_i
    end
  end
end
