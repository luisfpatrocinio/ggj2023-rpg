///@func Player()
function Player() : Entity() constructor {
	expPoints = 0;
	
	hpMax = 10;
	hp = hpMax;
	
	attack = 5;
	defense = 2;
	
	spd = 5;
	
	drawInfo = function(x, y) {
		draw_set_font(fntGame);
		draw_set_color(c_black);
		draw_set_halign(fa_center);
		var _str = string("", name, level, );
		draw_text(x, y, toString());
	}
}