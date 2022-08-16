Spree::Core::Engine.add_routes do
  # Add your extension routes here
  resources :razorpay, only: :create
end
