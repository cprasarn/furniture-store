// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var store_sales_tax = 9.25 * 0.01

$(function() {
    $('.datepicker').datepicker();
    $('.note').tooltip();
});

function toggle_display_mode(id)
{
	var display_mode = $('#' + id).css("display");
	display_mode = ('none' == display_mode ? 'block' : 'none');
	$('#' + id).css("display", display_mode);
}

function toggle_input_value(id, name, scope)
{
	var object = $('#' + id)
	var scope_object = (undefined == scope ? undefined : $('#' + scope)) 
	
	object.click(function() {
	    var value = object.val();
	    if (name == value) {
	        object.val('');
	    }
	});
	object.blur(function() {
	    var value = object.val();
	    var scope_value = (undefined == scope_object ? undefined : scope_object.val());
	    var scope_default_value = (undefined == scope_object ? undefined : scope_object.prop('defaultValue'));
  	    if ('' === value) {
  	    	if (undefined == scope_value || '' == scope_value || scope_default_value == scope_value)
  	    	{
  	 	    	object.val(name);
  	    	}
 	    }
	});
}

