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
    submitBtn.val("Processing...").prop('disabled', true);

  // Collect the credit card fields.
  var ccNum = $('#card_number').val(),
      cvcNum = $('#card_code').val(),
      expMonth = $('#card_month').val(),
      expYear = $('#card_year').val();
      
  // Use the Stripe JS library to check for card errors.
  var error = false;
  
  // Validate card.
  if (!Stripe.card.validateCardNumber(ccNum)) {
    error = true;
    alert('The credit card number appears to be invalid.');
  }
  
  if (!Stripe.card.validateCVC(cvcNum)) {
    error = true;
    alert('The CVC number for this credit card appears to be invalid.');
  }
  
  if (!Stripe.card.validateExpiry(expMonth, expYear)) {
    error = true;
    alert('The expiry date for this credit card appears to be invalid.');
  }
  
    if (error) {
      submitBtn.val("Sign up").prop('disabled', false);
    } else {
      // Send the card information to Stripe.
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, stripeResponseHandler);
      }
      return false;
      });
    // Stripe will return a card token.
    function stripeResponseHandler(status, response) {
      // Gets the token from the response.
      var token = response.id;
      
      // Inject the card token into a hidden field.
      proForm.append( $('input type="hidden" name="user[stripe_card_token]">').val(token) );
      
      // Submit the form to our rails application.
      proForm.get(0).submit();
    }
    });