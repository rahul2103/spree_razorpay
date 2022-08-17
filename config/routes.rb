Spree::Core::Engine.add_routes do
  # Add your extension routes here
  post '/razorpay/response', to: 'razorpay#response', as: :razorpay_response
end
