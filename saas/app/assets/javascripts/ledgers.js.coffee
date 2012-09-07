# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $('#new_payment_button').click ->
    # Pop-up
    
  $('#ledger_order_number').autocomplete
    source: (request, response) -> 
      $.ajax 
        url: '/orders/search'
        dataType: 'json'
        data:
          order_number: request.term
        success: (data) ->
          response data
        error: (xhr, options, err) ->
          alert 'Ledger Order Number[' + xhr.status + '] ' + err
      return
    select: (event, ui) -> 
      $('#ledger_order_number').val(ui.item.label)
  
  return
