module Spree
  module OrderDecorator
    def inr_amt_in_paise
      (amount.to_f * 100).to_i
    end

    ::Spree::Order.prepend self
  end
end