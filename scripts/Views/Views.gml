///@func View()
///@desc Tela a ser exibida e adicionada na global.viewStack.
function View() constructor {
	selectedAction = 0;
	actions = [];
	header = "";
		
	step = function() {
		getInput();
		
		// Caso tenhamos mensagem:
		if (ds_queue_head(global.messageStack) != undefined) {
			// Apertar tecla para avançar.
			if (pressedKey) {
				ds_queue_dequeue(global.messageStack);
			}
		} else {
			// Operar ações.
			if (array_length(actions) > 1) {
				// Selecionar ação
				selectedAction += sign(downKey - upKey);
				selectedAction = uc_wrap(selectedAction, 0, array_length(actions));
				
				// Confirmar
				if (pressedKey) {
					actions[selectedAction].callback();
				}
			}
		}
	}
	
	draw = function() {
		draw_clear_alpha(c_black, 0);
		var _c1 = c_navy;
		var _c2 = c_navy;
		draw_rectangle_color(0, 0, global.guiWidth, global.guiHeight, _c1, _c1, _c2, _c2, false);
		draw_set_halign(fa_center);
		draw_set_font(fntHeader);
		draw_text_color(global.guiWidth/2, 32, header, c_white, c_white, c_dkgray, c_dkgray, 1);
		
		// Caso tenhamos mensagem:
		if (ds_queue_size(global.messageStack) > 0) {
			drawMessage(ds_queue_head(global.messageStack));
			
			if (ds_queue_size(global.messageStack) > 1) {
				draw_set_color(c_orange);
				draw_text(global.guiWidth/2, global.guiHeight - 32, "[NEXT]");	
			}
			
		// Exibir ações
		} else if (array_length(actions) > 0) {
			array_foreach(actions, function(_item, _index) {
				_item.highlighted = selectedAction == _index;
				_item.draw(32, 120 + _index * 16);
			}, 0, array_length(actions));
		}
	}
}

function Action(_name, _function) constructor {
	name = _name;
	callback = _function;	
	
	highlighted = false;
	
	draw = function(x, y) {
		var _text = name;
		if (highlighted) _text = "> " + _text;
		draw_set_halign(fa_left);
		draw_text(x, y, _text);
	}
}