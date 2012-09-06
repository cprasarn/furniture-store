# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  ## Customer Name
  $('#customer_name').change ->
    value = $('#customer_name').val()
    if '' == value
      $('#customer_id').val('')

  ## Customer Autocomplete
  $('#customer_name').autocomplete
    source: (request, response) -> 
      $.ajax 
        url: '/customers/search'
        dataType: 'json'
        data:
          customer_name: request.term
        success: (data) ->
          response data
        error: (xhr, options, err) ->
          alert '[' + xhr.status + '] ' + err
      return
    select: (event, ui) -> 
      $('#customer_name').val(ui.item.label)
      
      # Customer detail
      Customer.clear_customer_detail()
      customer = ui.item.data
      if undefined != customer
        $('#customer_id').val(customer.id)
        $('#home_phone').val(customer.home_phone)
        $('#mobile_phone').val(customer.mobile_phone)
        $('#business_phone').val(customer.business_phone)
        $('#email').val(customer.email)
      
      # Default address
      Address.clear_address_detail()
      Address.get_default_address_detail(customer.id)
        
      return

  return
  
# Customer object
@Customer = ->
Customer.clear_customer_detail = ->
  $("#customer_id").val ""
  $("#customer_name").val ""
  $("#home_phone").val ""
  $("#mobile_phone").val ""
  $("#business_phone").val ""
  $("#email").val ""

Customer.get_customer_detail = (id) ->
  $.ajax
    url: "/customers/" + id
    dataType: "json"
    success: (customer) ->
      $("#customer_name").val customer.name
      $("#home_phone").val customer.home_phone
      $("#mobile_phone").val customer.mobile_phone
      $("#business_phone").val customer.business_phone
      $("#email").val customer.email

    error: (xhr, options, err) ->
      alert "Customer Detail[" + xhr.status + "] " + err
  