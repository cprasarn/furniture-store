# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  toggle_input_value 'order_number', 'NEW ORDER'
  
  ## Order Number
  $('#order_number').change ->
    value = $('#order_number').val()
    if '' == value
      Order.clear_info()
      Customer.clear_info()
      Address.clear_info()
  
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
      Order.fill_info order
      
      # Customer detail
      $('#customer_id').val(order.customer_id)
      Customer.info order.customer_id
      
      # Address detail
      $('#address_id').val(order.address_id)
      Address.info order.address_id 
      
      # Items
      Item.items_by_order order.order_number
      
      return            

  return

# Order Object  
@Order = ->
Order.clear_info = ->
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
  return

Order.fill_info = (data) ->
  order_date = undefined
  order_date = new Date(data.order_date)
  $("#order_id").val data.id
  $("#order_date").val order_date.toString("MM/dd/yyyy")
  $("#order_estimated_time").val data.estimated_time
  $("#order_delivery_option").val data.delivery_option
  $("#order_price").val data.price
  $("#order_sales_tax").val data.sales_tax
  $('#order_finishing').val data.finishing
  $('#order_delivery_charge').val data.delivery_charge
  
  subtotal = data.price + data.sales_tax
  $("#order_subtotal").val subtotal
  
  total = subtotal + data.finishing + data.delivery_charge
  $("#order_total").val total
  return

Order.info = (id) ->
  $.ajax
    url: "/orders/search"
    dataType: "json"
    data:
      order_number: id

    success: (data) ->
      Order.fill_order_detail data

    error: (xhr, options, err) ->
      alert "Order Detail[" + xhr.status + "] " + err


Order.update_balance = ->
  total = Only2cNumber.format_number('order_total')
  deposit = Only2cNumber.format_number('deposit_amount')
  balance = Only2cNumber.format_number('#order_balance', order_total - deposit)
  return

Order.update_total = ->
  subtotal = Only2cNumber.format_number('order_subtotal')
  finishing = Only2cNumber.format_number('order_finishing')
  delivery_charge = Only2cNumber.format_number('order_delivery_charge')
  total = Only2cNumber.format_number('order_total', subtotal + finishing + delivery_charge)
  
  Order.update_balance()
  return

Order.update_tax_and_subtotal = ->
  price = Only2cNumber.format_number('order_price')
  sales_tax = Only2cNumber.format_number('order_sales_tax', store_sales_tax * price)  
  subtotal = Only2cNumber.format_number('order_subtotal', price + sales_tax)
  
  Order.update_total()
  Order.update_balance()
  
Order.adjust_subtotal = ->
  subtotal = Only2cNumber.format_number('order_subtotal')
  price = Only2cNumber.format_number('order_price', subtotal / (1 + store_sales_tax))
  sales_tax = Only2cNumber.format_number('order_sales_tax', store_sales_tax * price)
  
  Order.update_total()
  return

Order.adjust_total = ->
  total = Only2cNumber.format_number('order_total')
  finishing = Only2cNumber.format_number('order_finishing')
  delivery_charge = Only2cNumber.format_number('order_delivery_charge')
  subtotal = Only2cNumber.format_number('order_subtotal', total - finishing - delivery_charge)
  
  if 0 < subtotal and 0 < total
    Order.adjust_subtotal()
  else
    Order.clear_price()
  end
  return
  
Order.clear_price = ->
  $('#order_price').val 0.00
  $('#order_sales_tax').val 0.00
  $('#order_subtotal').val 0.00
  $('#order_finishing').val ''
  $('#order_delivery_charge').val ''
  $('#order_total').val 0.00
  return

