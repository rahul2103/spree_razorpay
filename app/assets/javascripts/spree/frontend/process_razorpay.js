//= require spree/frontend

var RAZOR_PAY_OPTIONS = '#razor-pay-options'
var RAZOR_PAY_BUTTON = '#razorpay-button'

Spree.ready(function ($) {

  let razor_pay = $(RAZOR_PAY_BUTTON)

  var options = {
      "key": $(RAZOR_PAY_OPTIONS).data('razor-pay-key'),
      "amount": $(RAZOR_PAY_OPTIONS).data('razor-pay-amount'),
      "currency": $(RAZOR_PAY_OPTIONS).data('razor-pay-currency'),
      "name": $(RAZOR_PAY_OPTIONS).data('razor-pay-name'),
      "description": $(RAZOR_PAY_OPTIONS).data('razor-pay-description'),
      "callback_url": $(RAZOR_PAY_OPTIONS).data('razor-pay-callback-url'),
      "redirect": $(RAZOR_PAY_OPTIONS).data('razor-pay-redirect'),
      "order_id": $(RAZOR_PAY_OPTIONS).data('razor-pay-order-id'),
      "prefill": {
          "name": $(RAZOR_PAY_OPTIONS).data('razor-pay-prefill-name'),
          "email": $(RAZOR_PAY_OPTIONS).data('razor-pay-prefill-email'),
          "contact": $(RAZOR_PAY_OPTIONS).data('razor-pay-prefill-contact')
      },
      "notes": {
          "address": $(RAZOR_PAY_OPTIONS).data('razor-pay-notes-address')
      },
      "theme": {
        "color": $(RAZOR_PAY_OPTIONS).data('razor-pay-theme-color')
      }
  };

  if ( razor_pay.length > 0 ) {
    var rzp1 = new Razorpay(options);
  }

  document.getElementById('razorpay-button').onclick = function(e){
      rzp1.open();
      e.preventDefault();
  }
})
