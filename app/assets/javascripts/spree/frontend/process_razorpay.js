//= require spree/frontend

var RAZOR_PAY_OPTIONS = '#razor-pay-options'
var RAZOR_PAY_BUTTON = '#razorpay-button'

document.addEventListener('turbolinks:load', function () {
  $(document).ready(function () {
    var razorpayButton = $(RAZOR_PAY_BUTTON)

    function paymentOptions() {
      "key": $(RAZOR_PAY_OPTIONS).data('razor-pay-key'),
      "amount": $(RAZOR_PAY_OPTIONS).data('razor-pay-amount'),
      "currency": "INR",
      "name": $(RAZOR_PAY_OPTIONS).data('razor-pay-name'),
      "description": $(RAZOR_PAY_OPTIONS).data('razor-pay-description'),
      "callback_url": $(RAZOR_PAY_OPTIONS).data('razor-pay-callback-url'),   
    }

    function notesOptions() {
      "notes": {
          "address": $(RAZOR_PAY_OPTIONS).data('razor-pay-notes-address')
      }
    }

    function prefillOptions() {
      "prefill": {
          "name": $(RAZOR_PAY_OPTIONS).data('razor-pay-prefill-name'),
          "email": $(RAZOR_PAY_OPTIONS).data('razor-pay-prefill-email'),
          "contact": "9999999999"
      }
    }

    function themeOptions() {
      "theme": {
          "color": $(RAZOR_PAY_OPTIONS).data('razor-pay-theme-color')
      }
    }

    function processOptions() {
      var options = {
        paymentOptions(),
        prefillOptions(),
        notesOptions(),
        themeOptions()

      }

      return options
    }

    if (razorpayButton.length > 0) {
      var rzp1 = new Razorpay(processOptions());

      $(razorpayButton).onclick = function(e){
          rzp1.open();
          e.preventDefault();
      }
    }
  })
})
