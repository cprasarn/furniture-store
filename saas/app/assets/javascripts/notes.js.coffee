# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $('#new_note_dialog').dialog
    autoOpen: false
    height: 320
    width: 455
    modal: true
    buttons: 
      Cancel: ->
        $(this).dialog("close")
      "Create a Note": ->
        $.ajax
          type: "POST"
          url: "/notes"
          dataType: "html"
          data:
            order_number: $('#note_order_number').val()
            content: $('#note_content').val()
          success: (data) ->
            if $('#note_no_record') and 'block' == $('#note_no_record').css("display")
              $('#note_no_record').hide()
            notes = $('#new_note').html()
            $('#new_note').html notes + data
          error: (xhr, options, err) ->
            alert "New Note[" + xhr.status + "] " + err
          complete: (xhr, status) ->
            $('#new_note_dialog').dialog("close")
  
  $('#new_note_button').click ->
    $('#new_note_dialog').dialog("open");
    return
  
  return 