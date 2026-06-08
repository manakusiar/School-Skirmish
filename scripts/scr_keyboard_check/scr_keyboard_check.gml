function keyboard_global(key) {
	var _check = 0
	
	if global.in_conversation = 0 _check = keyboard_check(key)
	
	return _check
}

function keyboard_global_pressed(key) {
	var _check = 0
	
	if global.in_conversation = 0 _check = keyboard_check_pressed(key)
	
	return _check
}

function keyboard_global_released(key) {
	var _check = 0
	
	if global.in_conversation = 0 _check = keyboard_check_released(key)
	
	return _check
}