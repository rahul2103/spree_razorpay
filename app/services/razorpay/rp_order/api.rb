require "uri"
require "json"
require "net/http"

module Razorpay
  module RpOrder
    class Api < Razorpay::Base

      attr_reader :order, :razorpay_checkout

      def create(order_token)
        @order = Spree::Order.find_by_token(order_token)
        @razorpay_checkout = Spree::RazorpayCheckout.find_by_order_id(@order.id)

        debugger

        return @razorpay_checkout.razorpay_order_id if @razorpay_checkout.present?

        url = URI(order_create_url)
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(url)
        request["Content-Type"] = "application/json"
        request["Authorization"] = basic_auth_token
        request.body = JSON.dump(order_create_params)

        response = https.request(request)
        parsed_data = JSON.parse(response.body)

        debugger

        if response.code == '200'
          save_razorpay_order(parsed_data)

          return parsed_data['id']
        else
          return ''
        end

      rescue Exception => e
        e
      end

      private

      def order_create_params
       {
          "amount": @order.total,
          "currency": @order.currency
        }
      end

      def order_create_url
        "https://api.razorpay.com/v1/orders"
      end

      def basic_auth_token
        "Basic #{Base64.strict_encode64("#{payment_method.preferred_key_id}:#{payment_method.preferred_key_secret}")}"
      end

      def save_razorpay_order(response_data)
        Spree::RazorpayCheckout.find_or_create_by(
          order_id: @order.id,
          razorpay_order_id: response_data['id']
          )
      end
    end 
  end
end
