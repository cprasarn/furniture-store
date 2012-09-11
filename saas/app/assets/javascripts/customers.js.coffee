# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  ## Customer Name
  $('#customer_name').change ->
    value = $('#customer_name').val()
    if '' == value
      Customer.clear_info()
      Address.clear_info()

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
      Customer.clear_info
      customer = ui.item.data
      if undefined != customer
        Customer.fill_info customer
      
      # Default address
      Address.clear_info()
      Address.default_info(customer.id)
        
      return

  return
  
# Customer object
@Customer = ->
Customer.clear_info = ->
  $("#customer_id").val ""
  $("#customer_name").val ""
  $("#customer_home_phone").val ""
  $("#customer_mobile_phone").val ""
  $("#customer_business_phone").val ""
  $("#customer_email").val ""

Customer.fill_info = (data) ->
  $("#customer_id").val data.id
  $("#customer_name").val data.name
  $("#customer_home_phone").val data.home_phone
  $("#customer_mobile_phone").val data.mobile_phone
  $("#customer_business_phone").val data.business_phone
  $("#customer_email").val data.email
  return

Customer.info = (id) ->
  $.ajax
    url: "/customers/" + id
    dataType: "json"
    success: (customer) ->
      Customer.fill_info customer
    error: (xhr, options, err) ->
      alert "Customer Detail[" + xhr.status + "] " + err
  