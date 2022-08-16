Spree::Core::Engine.add_routes do
  # Add your extension routes here
  post 'razorpay', to: 'razorpay#razorpay', as: :razorpay
end
