module Spree
  class RazorpayController < StoreController

    before_action :provider, only: [:razorpay]

    # def razorpay
    #   debugger 

    #   order = current_order || raise(ActiveRecord::RecordNotFound)

    #   rp_response = payment_method.process_razor_payment(params, order)

    #   begin
    #     rp_response = provider.process_razor_payment(params, order)

    #     debugger

    #     if pp_response.success?
    #       # redirect_to provider.express_checkout_url(pp_response, useraction: 'commit')
    #     else
    #       debugger

    #       flash[:error] = Spree.t('flash.generic_error', scope: 'paypal', reasons: pp_response.errors.map(&:long_message).join(" "))
    #       redirect_to checkout_state_path(:payment)
    #     end
    #   rescue SocketError
    #     flash[:error] = Spree.t('flash.connection_failed', scope: 'paypal')
    #     redirect_to checkout_state_path(:payment)
    #   end

    # end

    def create
      debugger

      response_status = payment_method.process_razor_payment(params, current_order)
      @order = current_order
      if response_status == 'captured'
        @order.next
        @message = Spree.t(:order_processed_successfully)
        @current_order = nil
        flash.notice = Spree.t(:order_processed_successfully)
        flash['order_completed'] = true
        @error = false
        @redirect_path = order_path(@order)
      else
        @order.update_attributes(payment_state: 'failed')
        @error = true
        @message = 'There was an error processing your payment'
        @redirect_path = checkout_state_path(@order.state)
      end
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
