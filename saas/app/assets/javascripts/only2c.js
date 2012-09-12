
function Only2cNumber() {}

Only2cNumber.format_number = function(name, value, position) {
	// Default position value is 2
	var p = (undefined == position ? 2 : position);

	var id = '#' + name;
	var v = (undefined == value ? $(id).val() : value);
	var result = new Number(v).toFixed(p);
	$(id).val(result);
	
	return parseFloat(result);
}