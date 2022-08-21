module Spree
  class RazorpayController < StoreController
    skip_before_action :verify_authenticity_token
    before_action :provider, only: [:response]
    include Spree::RazorPay

    def response


      if params['razorpay_payment_id'].present?
        rp_fetch = Razorpay::Payment.fetch(params['razorpay_payment_id'])
        
        debugger

        update_razorpay_checkout(rp_fetch)
      else
        debugger

        flash[:error] = params['error']['description']
        redirect_to checkout_state_path(order.state)
      end



    end

    private

    def payment_method
      Spree::PaymentMethod.find(params[:payment_method_id])
    end

    def order
      Spree::Order.find_by(number: params[:order_id])
    end

    def provider
      payment_method.provider
    end
  end
end

# {"razorpay_payment_id"=>"pay_K8Gl4YjFW98RDX", "razorpay_order_id"=>"order_K8Fy89rtVrzt68", "razorpay_signature"=>"29f13d6c8b8f1cfe6d5d073e1413d8253932165cbc4b67b899db694d992a4929", "order_id"=>"R935131629", "payment_method_id"=>"1", "controller"=>"spree/razorpay", "action"=>"response"}