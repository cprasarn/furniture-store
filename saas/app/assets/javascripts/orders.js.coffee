# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  ## Order Number
  $('#order_number').change ->
    value = $('#order_number').val()
    if '' == value
      Order.clear_order_detail()
      Customer.clear_customer_detail()
      Address.clear_address_detail()
  
  toggle_input_value 'order_number', 'NEW ORDER'
  
  ## Order Autocomplete  
  $('#order_number').autocomplete
    source: (request, response) -> 
      $.ajax 
        url: '/orders/search'
        dataType: 'json'
        data:
          order_number: request.term
          order_date: $('#order_date').val()
          customer_id: $('#customer_id').val()
        success: (data) ->
          response data
        error: (xhr, options, err) ->
          alert '[' + xhr.status + '] ' + err
      return
    select: (event, ui) -> 
      $('#order_number').val(ui.item.label)
      
      # Order detail
      order = ui.item.data
      order_date = new Date(order.order_date)
      $('#order_date').val(order_date.toString('MM/dd/yyyy'))
      $('#order_price').val(order.price)
      $('#order_sales_tax').val(order.sales_tax)
      $('#order_subtotal').val(order.subtotal)
      $('#order_finishing').val(order.finishing)
      $('#order_delivery_charge').val(order.delivery_charge)
      $('#order_total').val(order.total)
      $('#order_estimated_time').val(order.estimated_time)
      $('#order_delivery_option').val(order.delivery_option)
      
      # Customer detail
      $('#customer_id').val(order.customer_id)
      Customer.get_customer_detail order.customer_id
      
      # Address detail
      $('#address_id').val(order.address_id)
      Address.get_address_detail order.address_id 
      
      return            

  return

# Order Object  
@Order = ->
Order.clear_order_detail = ->
  today = undefined
  today = new Date()
  $("#order_date").val today.toString("MM/dd/yyyy")
  $("#order_number").val "NEW ORDER"
  $("#order_estimated_time").val ""
  $("#order_delivery_option").val ""
  $("#order_price").val ""
  $("#order_sales_tax").val ""
  $("#order_subtotal").val ""
  $("#order_total").val ""

Order.get_order_detail = (id) ->
  $.ajax
    url: "/orders/search"
    dataType: "json"
    data:
      order_number: id

    success: (data) ->
      order_date = undefined
      order_date = new Date(data.order_date)
      $("#order_date").val order_date.toString("MM/dd/yyyy")
      $("#order_price").val data.price
      $("#order_sales_tax").val data.sales_tax
      $("#order_estimated_time").val data.estimated_time
      $("#order_delivery_option").val data.delivery_option

    error: (xhr, options, err) ->
      alert "Order Detail[" + xhr.status + "] " + err


Order.update_balance = ->
  balance = undefined
  deposit = undefined
  order_total = undefined
  _ref = undefined
  order_total = $("#order_total").val()
  if "" is order_total
    order_total = 0
  else
    order_total = parseFloat(order_total)
  deposit = $("#deposit_amount").val()
  deposit = (if (_ref = "" is deposit)? then _ref else 0: parseFloat(deposit))
  balance = order_total - deposit
  $("#order_balance").val balance

Order.update_total = ->
  delivery_charge = undefined
  finishing = undefined
  subtotal = undefined
  total = undefined
  subtotal = $("#order_subtotal").val()
  if "" is subtotal
    subtotal = 0
  else
    subtotal = parseFloat(subtotal)
  finishing = $("#order_finishing").val()
  if "" is finishing
    finishing = 0
  else
    finishing = parseFloat(finishing)
  delivery_charge = $("#order_delivery_charge").val()
  if "" is delivery_charge
    delivery_charge = 0
  else
    delivery_charge = parseFloat(delivery_charge)
  total = subtotal + finishing + delivery_charge
  $("#order_total").val total
  Order.update_balance

Order.update_tax_and_subtotal = ->
  price = undefined
  sales_tax = undefined
  subtotal = undefined
  price = $("#order_price").val()
  if "" is price
    price = 0
  else
    price = parseFloat(price)
  sales_tax = 9.25 * 0.01 * price
  subtotal = price + sales_tax
  $("#order_sales_tax").val sales_tax
  $("#order_subtotal").val subtotal
  Order.update_total()
  Order.update_balance()