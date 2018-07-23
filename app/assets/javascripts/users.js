/* global Stripe $ */

// Document ready.
$(document).on('turbolinks:load', function(){
  
  // Assign variables to required HTML elements.
  var proForm = $('#pro_form');
  var submitBtn = $('#form-submit-btn');
  
  // Set Stripe Public Key.
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
  
  // Prevent default submission behvaviour.    
  submitBtn.click(function(event){
    event.preventDefault();

  // Collect the credit card fields.
  var ccNum = $('#card_number').val(),
      cvcNum = $('#card_code').val(),
      expMonth = $('#card_month').val(),
      expYear = $('#card_year').val();
  
  // Send the card information to Stripe.
  Stripe.createToken({
    number: ccNum,
    cvc: cvcNum,
    exp_month: expMonth,
    exp_year: expYear
  }, StripeResponseHandler);
  
  });
  
  
  

  // Stripe will return a card token.
  // Inject the card token as a hidden field.
  // Submit the form to our rails application.

});