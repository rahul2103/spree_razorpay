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
  end
end
