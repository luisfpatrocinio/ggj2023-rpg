function Action(_name, _function) constructor {
	name = _name;
	callback = _function;
	
	selectedTimer = 0;
	drawX = 0;
	drawY = 0;
	
	highlighted = false;
	
	draw = function(x, y) {
		var _text = name;
		
		drawX = x + selectedTimer;
		drawY = y;
		selectedTimer = approach(selectedTimer, 0, 1);
		
		#region Draw Box
		var _bb = 2;
		var _x1 = drawX - _bb;
		var _x2 = drawX + string_width(_text) + _bb;
		var _y1 = drawY - _bb;
		var _y2 = drawY + string_height(_text) + _bb;
	
		// Box Outline
		var _bc = c_orange;
		draw_rectangle_color(_x1, _y1, _x2, _y2, _bc, _bc, _bc, _bc, true);
	
		// Box
		var _boxColor = highlighted ? c_orange : c_black;
		draw_rectangle_color(_x1, _y1, _x2, _y2, _boxColor, _boxColor, _boxColor, _boxColor, false);
		#endregion
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		var _c = highlighted ? c_white : c_dkgray;
		draw_text_color(drawX, drawY, _text, _c, _c, _c, _c, 1);
	}
}

function InventoryAction() : Action("Inventário", undefined) constructor {
	callback = function() {
		ds_stack_push(global.viewStack, new InventoryView());	
	};
}