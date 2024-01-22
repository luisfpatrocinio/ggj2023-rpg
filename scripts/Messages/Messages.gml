global.messageStack = ds_queue_create();

function addMessage(msg) {
	var _message = new Message(msg);
	ds_queue_enqueue(global.messageStack, _message);
}

///@func drawMessage()
///@desc Desenha uma Message na tela.
///@param _msg {Message} Mensagem a ser desenhada
function drawMessage(_msg){
	var msg = _msg;
	var _b = 32;
	
	var _x = _b;
	var _y = floor(global.guiHeight * 2/3);
	
	var _sep = 16;
	
	#region Draw Box
	var _bb = 2;
	var _x1 = _b - _bb;
	var _x2 = global.guiWidth - _b + _bb;
	var _y1 = _y - _bb;
	var _y2 = _y + string_height_ext(msg.text, _sep, global.guiWidth - _b * 2) + _bb;
	
	// Box Outline
	var _bc = c_orange;
	draw_rectangle_color(_x1, _y1, _x2, _y2, _bc, _bc, _bc, _bc, true);
	
	// Box
	draw_rectangle_color(_x1, _y1, _x2, _y2, c_black, c_black, c_black, c_black, false);
	#endregion
	
	// Draw Text
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(fntMessage);
	draw_set_color(c_aqua);
	draw_text_ext(_x, _y, msg.text, _sep, global.guiWidth - _b * 2);
}

///@func Message
///@param _text {string}
function Message(_text) constructor {
	text = _text;
}