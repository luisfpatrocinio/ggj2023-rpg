/// @description 
live_auto_call 
if (keyboard_check_pressed(vk_f1)) {
	game_restart();	
}

if (keyboard_check_pressed(vk_f2)) {
	room_restart();
}

if (keyboard_check_pressed(vk_f3)) {
	obtainItem(new TestItem());
}
