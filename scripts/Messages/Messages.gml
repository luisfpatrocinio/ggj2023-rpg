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
	draw_set_halign(fa_left);
	draw_set_font(fntMessage);
	draw_set_color(c_aqua);
	draw_text_ext(_b, 224, msg.text, 16, global.guiWidth - _b * 2);
}

///@func Message
///@param _text {string}
function Message(_text) constructor {
	text = _text;
}