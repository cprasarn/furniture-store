# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $('#new_ledger_dialog').dialog
    autoOpen: false
    height: 360
    width: 455
    modal: true
    buttons: 
      Cancel: ->
        $(this).dialog("close")
      "Create Payment Record": ->
        new_ledger_amount = Only2cNumber.parse_float('ledger_amount')
        $.ajax
          type: "POST"
          url: "/ledgers"
          dataType: "html"
          data:
            order_number: $('#ledger_order_number').val()
            payment_date: $('#ledger_payment_date').val()
            payment_type: $('#ledger_payment_type').val()
            payment_method: $('#ledger_payment_method').val()
            amount: new_ledger_amount
            status: $('#ledger_status').val()
          success: (data) ->
            if $('#ledger_no_record') and 'block' == $('#ledger_no_record').css("display")
              $('#ledger_no_record').hide()
            ledgers = $('#new_ledger').html()
            $('#new_ledger').html ledgers + data
            
            # Remaining balance
            Ledger.remaining_balance new_ledger_amount
          error: (xhr, options, err) ->
            alert "New Payment[" + xhr.status + "] " + err
          complete: (xhr, status) ->
            $('#new_ledger_dialog').dialog("close")
  
  $('#new_ledger_button').click ->
    $('#new_ledger_dialog').dialog("open");
    return
  
  return

# Ledger Object  
@Ledger = ->
Ledger.remaining_balance = (new_ledger_amount) ->
  if undefined != $('#remaining_balance')
    remaining_balance = Only2cNumber.parse_float('remaining_balance')
    remaining_balance -= new_ledger_amount
    remaining_balance = (if 0 is remaining_balance then 'PAID' else remaining_balance)  
    $('#remaining_balance').html remaining_balance
  