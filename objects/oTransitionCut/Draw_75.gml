/// @description 
if (life > 0) life--;
else instance_destroy();

display_set_gui_size(global.guiWidth, global.guiHeight);
var _c = c_black;
draw_rectangle_color(0, 0, global.guiWidth, global.guiHeight, _c, _c, _c, _c, false);