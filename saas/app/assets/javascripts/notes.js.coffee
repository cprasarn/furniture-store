# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $('#note_dialog').dialog
    autoOpen: false
    height: 385
    width: 460
    modal: true
    buttons: 
      Cancel: ->
        $(this).dialog("close")
      "Create Note": ->
        Note.create $(this).attr('id')
      "Modify Note": ->
        Note.modify $(this).attr('id')
      "Remove Note": ->
        Note.remove $(this).attr('id')
    close: ->
      Note.clear_dialog()
  
  return 
  
# Note Object
@Note = ->
Note.clear_dialog = ->
  $('#note_id').val ''
  $('#note_content').val ''
  return

Note.fill_dialog = (data, readonly) ->
  $('#note_id').val data.id
  $('#note_content').val data.content
  return

Note.info_dialog = (id, readonly) ->
  $.ajax
    type: "GET"
    url: "/notes/" + id
    dataType: "json"
    data:
      id: id
    success: (data) ->
      Note.fill_dialog data, readonly
    error: (xhr, options, err) ->
      alert "Note::info[" + xhr.status + "] " + err
  return
  
Note.new_dialog = ->
  $('#note_dialog').dialog("open")
  $('#note_dialog').dialog('option', 'title', 'New Note');
  $(":button:contains('Create Note')").show()
  $(":button:contains('Modify Note')").hide()
  $(":button:contains('Remove Note')").hide()
  return
  
Note.modify_dialog = (id) ->
  Note.info_dialog id, false
  $('#note_dialog').dialog("open")
  $('#note_dialog').dialog('option', 'title', 'Modify Note');
  $(":button:contains('Modify Note')").show()
  $(":button:contains('Create Note')").hide()
  $(":button:contains('Remove Note')").hide()
  return

Note.remove_dialog = (id) ->
  Note.info_dialog id, true
  $('#note_dialog').dialog("open")
  $('#note_dialog').dialog('option', 'title', 'Remove Note');
  $(":button:contains('Modify Note')").hide()
  $(":button:contains('Create Note')").hide()
  $(":button:contains('Remove Note')").show()
  return

Note.create = (dialog_name) ->
  $.ajax
    type: "POST"
    url: "/notes"
    dataType: "html"
    data:
      note:
        order_number: $('#note_order_number').val()
        content: $('#note_content').val()
    success: (data) ->
      if $('#note_no_record') and 'block' == $('#note_no_record').css("display")
        $('#note_no_record').hide()
      notes = $('#new_note').html()
      $('#new_note').html notes + data
    error: (xhr, options, err) ->
      alert "Note::create[" + xhr.status + "] " + err
    complete: (xhr, status) ->
      $('#' + dialog_name).dialog("close")
  return
  
Note.modify = (dialog_name) ->
  note_id = $('#note_id').val()
  $.ajax
    type: "PUT"
    url: "/notes/" + note_id
    dataType: "html"
    data:
      note:
        id: note_id
        order_number: $('#note_order_number').val()
        content: $('#note_content').val()
    success: (data) ->
      $('#notes_list_form').html data
    error: (xhr, options, err) ->
      alert "Note::modify[" + xhr.status + "] " + err
    complete: (xhr, status) ->
      $('#' + dialog_name).dialog("close")
  return
  
Note.remove = (dialog_name) ->
  note_id = $('#note_id').val()
  $.ajax
    type: "DELETE"
    url: "/notes/" + note_id
    dataType: "json"
    success: (data) ->
      $('#' + note_id).hide()
    error: (xhr, options, err) ->
      alert "Note::remove[" + xhr.status + "] " + err
    complete: (xhr, status) ->
      $('#' + dialog_name).dialog("close")
  return
