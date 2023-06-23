Spree::Core::Engine.add_routes do
  # Add your extension routes here
  post '/razorpay/response', to: 'razorpay#razor_response', as: :razorpay_response
end
