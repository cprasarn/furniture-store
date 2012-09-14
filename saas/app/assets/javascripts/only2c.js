
function Only2cNumber() {}

Only2cNumber.parse_float = function(name, value, position) {
	// Default position value is 2
	var p = (undefined == position ? 2 : position);
	
	var id = '#' + name;
	var v = (undefined == value) 
	    ? ($(id).is('span') ? $(id).text() : $(id).val()) 
	    : value;
	var result = new Number(v.replace(/[^0-9\.]+/g,"")).toFixed(p);
	return parseFloat(result);
}

Only2cNumber.format_number = function(name, value, position) {
	var result = Only2cNumber.parse_float(name, value, position);
	$(id).val(result);
	return result;
}

Only2cNumber.format_currency = function(name, value, position) {
	var result = Only2cNumber.parse_float(value, position);
	$(id).val('$' + result);
}

function Only2cDate() {}

Only2cDate.format_date = function(date_string, format) {
	var f = (undefined == format ? 'MM/dd/yyyy' : format);
	var date_pattern = /\d\d\d\d-\d\d-\d\d$/;
	if (date_pattern.test(date_string))
	{
		date_string += ' 00:00:00';
	}
	var date = new Date(date_string.replace(/[TZ]/g, " "));
	return date.toString(f);
}