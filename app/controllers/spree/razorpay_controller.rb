module Spree
  class RazorpayController < StoreController
    skip_before_action :verify_authenticity_token

    include Spree::RazorPay

    def razor_response
      if params['razorpay_payment_id'].present? && Razorpay::Utility.verify_payment_signature(update_razorpay_response)
        razorpay_pmnt_obj = Razorpay::Payment.fetch(params[:razorpay_payment_id])

        load_order.razor_payment(razorpay_pmnt_obj, payment_method, params['razorpay_signature'])
        load_order.next

        redirect_to(checkout_state_path(load_order.state)) && return unless load_order.completed?

        flash['order_completed'] = true
        redirect_to(completion_route) && return
      else
        flash[:error] = params[:error][:description]
        redirect_to(checkout_state_path(load_order.state)) && return
      end
    end

    private

    def payment_method
      Spree::PaymentMethod.find(params[:payment_method_id])
    end

    def provider
      payment_method.provider
    end

    def load_order
      Spree::Order.find_by(number: params[:order_id])
    end

    def completion_route
      order_path(load_order)
    end
  end
end
