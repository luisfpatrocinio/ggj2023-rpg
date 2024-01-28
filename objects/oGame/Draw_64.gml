/// @description 
live_auto_call 

var gui_width = global.guiWidth;
var gui_height = global.guiHeight;
display_set_gui_size(gui_width, gui_height);

// Desenhar a view atual:
var _view = ds_stack_top(global.viewStack);
if (!is_undefined(_view)) {
	_view.draw();
}