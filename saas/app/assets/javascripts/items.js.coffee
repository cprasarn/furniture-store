# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  original_submit_text = $('#submit_button').text()
  
  $("form#new_item").bind("ajax:beforeSend", (evt, xhr, settings) ->
    alert '[customer::id] ' + $('#customer_id').val()
    $('#submit_button').text 'Submitting...'
  ).bind("ajax:success", (evt, data, status, xhr) ->
    $form = $(this)
    alert 'success[' + data.order_number + ']: ' + data.image_uri
    if data.sketchup
      window.location = "skp:export_image@" + data.image_uri
    else
      window.location = '/orders/search?order_number=' + data.order_number
  ).bind("ajax:complete", (evt, xhr, status) ->
    $('#submit_button').text = original_submit_text 
    return
  ).bind "ajax:error", (evt, xhr, status, error) ->
    alert error
    $form = $(this)
    errors = undefined
    errorText = undefined
      
    try
      # Populate errorText with the comment errors
      errors = $.parseJSON(xhr.responseText)
    catch err
      # If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
      errors = message: "Please reload the page and try again"
    
    # Build an unordered list from the list of errors
    errorText = "There were errors with the submission: \n<ul>"
    for error of errors
      errorText += "<li>" + error + ": " + errors[error] + "</li> "
      errorText += "</ul>"
    
    # Insert error list into form
    $form.find("div.validation-error").html errorText    
  return      

# Item object
@Item = ->
Item.get_items_by_order = (order_id) ->
    $.ajax
      url: '/items/search'
      dataType: 'json'
      data:
        order_number: $('#order_number').val()
      success: (data) ->
        alert data[0]
      error: (xhr, options, err) ->
        alert 'Items[' + xhr.status + '] ' + err
    return     

