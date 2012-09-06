# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  toggle_input_value 'address_street1', 'street 1'
  toggle_input_value 'address_street2', 'street 2'
  toggle_input_value 'address_city', 'city'
  toggle_input_value 'address_zip_code', 'zip code'
  return

@Address = ->
Address.clear_address_detail = ->
  $("#address_id").val ""
  $("#address_street1").val "street1"
  $("#address_street2").val "street2"
  $("#address_city").val "city"
  $("#address_state").val "IL"
  $("#address_zip_code").val "zip code"

Address.get_address_detail = (id) ->
  $.ajax
    url: "/addresses/" + id
    dataType: "json"
    success: (data) ->
      $("#address_street1").val data.street1
      $("#address_street2").val data.street2
      $("#address_city").val data.city
      $("#address_state").val data.state
      $("#address_zip_code").val data.zip_code

    error: (xhr, options, err) ->
      alert "Address Detail[" + xhr.status + "] " + err


Address.get_default_address_detail = (customer_id) ->
  $.ajax
    url: "/customers_addresses/search"
    dataType: "json"
    data:
      customer_id: customer_id
      is_primary: 1
    success: (list) ->
      if list.length
        first = list.shift()
        data = Address.get_address_detail(first.name)
        $("#address_street1").val data.street1
        $("#address_street2").val data.street2
        $("#address_city").val data.city
        $("#address_state").val data.state
        $("#address_zip_code").val data.zip_code

    error: (xhr, options, err) ->
      alert "Default Address[" + xhr.status + "] " + err
