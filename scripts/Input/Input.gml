function getInput() {
	pressedKey = keyboard_check_pressed(vk_enter);
	cancelKey = keyboard_check_pressed(vk_escape);
	downKey = keyboard_check_pressed(vk_down);
	upKey = keyboard_check_pressed(vk_up);
	leftKey = keyboard_check_pressed(vk_left);
	rightKey = keyboard_check_pressed(vk_right);
}