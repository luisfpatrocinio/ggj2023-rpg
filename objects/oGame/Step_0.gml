/// @description 
live_auto_call 
// Operar view atual:
var _view = ds_stack_top(global.viewStack);
if (!is_undefined(_view)) {
	_view.step();
}

/* DEBUG */
if (keyboard_check_pressed(vk_space)) {
	var _enemy = new Enemy();
	_enemy.name = "Mimic";
	array_push(enemies, _enemy);	
}

if (keyboard_check_pressed(ord("1"))) {
	var _msg = $"Testando. Data: {date_datetime_string(date_current_datetime())}";
	addMessage(_msg);
}