# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  # Ledger modal dialog
  $('#ledger_dialog').dialog
    autoOpen: false
    height: 375
    width: 440
    modal: true
    buttons: 
      Cancel: ->
        $(this).dialog("close")
      "Create Payment": ->
        Ledger.create $(this).attr('id')
      "Modify Payment": ->
        Ledger.modify $(this).attr('id')
      "Remove Payment": ->
        Ledger.remove $(this).attr('id')
    close: ->
      Ledger.clear_dialog()

  return

# Ledger Object  
@Ledger = ->
Ledger.remaining_balance = (new_ledger_amount) ->
  if undefined != $('#remaining_balance')
    remaining_balance = Only2cNumber.parse_float('remaining_balance')
    remaining_balance -= new_ledger_amount
    remaining_balance = (if 0 is remaining_balance then 'PAID' else '&#36;' + remaining_balance)  
    $('#remaining_balance').html remaining_balance
  return

Ledger.clear_dialog = ->
  $('#ledger_id').val ''
  $('#ledger_payment_date').val ''
  $('#ledger_payment_type').val ''
  $('#ledger_payment_method').val ''
  $('#ledger_amount').val ''
  $('#ledger_status').val 1
  return

Ledger.fill_dialog = (data, readonly) ->
  $('#ledger_id').val data.id
  $('#ledger_payment_type').val data.payment_type
  $('#ledger_payment_method').val data.payment_method
  $('#ledger_amount').val data.amount.toFixed(2) 
  $('#ledger_status').val data.status

  # Payment Date  
  payment_date = Only2cDate.format_date(data.payment_date)
  $('#ledger_payment_date').val payment_date 
  return

Ledger.info_dialog = (id, readonly) ->
  $.ajax
    type: "GET"
    url: "/ledgers/" + id
    dataType: "json"
    data:
      id: id
    success: (data) ->
      Ledger.fill_dialog data, readonly
    error: (xhr, options, err) ->
      alert "Ledger::info[" + xhr.status + "] " + err
  return

Ledger.new_dialog = ->
  $('#ledger_dialog').dialog("open")
  $('#ledger_dialog').dialog('option', 'title', 'New Payment');
  $(":button:contains('Create Payment')").show()
  $(":button:contains('Modify Payment')").hide()
  $(":button:contains('Remove Payment')").hide()
  return
  
Ledger.modify_dialog = (id) ->
  Ledger.info_dialog id, false
  $('#ledger_dialog').dialog("open")
  $('#ledger_dialog').dialog('option', 'title', 'Modify Payment');
  $(":button:contains('Create Payment')").hide()
  $(":button:contains('Modify Payment')").show()
  $(":button:contains('Remove Payment')").hide()
  return

Ledger.remove_dialog = (id) ->
  Ledger.info_dialog id, true
  $('#ledger_dialog').dialog("open")
  $('#ledger_dialog').dialog('option', 'title', 'Remove Payment');
  $(":button:contains('Create Payment')").hide()
  $(":button:contains('Modify Payment')").hide()
  $(":button:contains('Remove Payment')").show()
  return

Ledger.create = (dialog_name) ->
  new_ledger_amount = Only2cNumber.parse_float('ledger_amount')
  $.ajax
    type: "POST"
    url: "/ledgers"
    dataType: "html"
    data:
      ledger:
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
      alert "Ledger::create[" + xhr.status + "] " + err
    complete: (xhr, status) ->
      $('#' + dialog_name).dialog("close")
  return

Ledger.modify = (dialog_name) ->
  ledger_id = $('#ledger_id').val()
  ledger_amount = Only2cNumber.parse_float('ledger_amount')
  $.ajax
    type: "PUT"
    url: "/ledgers/" + ledger_id
    dataType: "html"
    data:
      ledger:
        id: ledger_id
        order_number: $('#ledger_order_number').val()
        payment_date: $('#ledger_payment_date').val()
        payment_type: $('#ledger_payment_type').val()
        payment_method: $('#ledger_payment_method').val()
        amount: ledger_amount
        status: $('#ledger_status').val()
    success: (data) ->
      $('#ledgers_list_form').html data
      
      # Remaining balance
    error: (xhr, options, err) ->
      alert "Ledger::modify[" + xhr.status + "] " + err
    complete: (xhr, status) ->
      $('#' + dialog_name).dialog("close")
  return

Ledger.remove = (dialog_name) ->
  ledger_id = $('#ledger_id').val()
  debit_ledger_amount = (-1) * Only2cNumber.parse_float('ledger_amount')
  $.ajax
    type: "DELETE"
    url: "/ledgers/" + ledger_id
    dataType: "json"
    success: (data) ->
      $('#' + ledger_id).hide()
      
      # Remaining Balance
      Ledger.remaining_balance debit_ledger_amount
    error: (xhr, options, err) ->
      alert "Ledger::remove[" + xhr.status + "] " + err
    complete: (xhr, status) ->
      $('#' + dialog_name).dialog("close")
  return
  