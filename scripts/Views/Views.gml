///@func View()
///@desc Tela a ser exibida e adicionada na global.viewStack.
function View() constructor {
	selectedAction = 0;
	actions = [];
	header = "";
	
	headerColor = c_white;
	
	canReturn = false;
		
	step = function() {
		getInput();
		
		// Caso tenhamos mensagem:
		if (ds_queue_head(global.messageStack) != undefined) {
			// Apertar tecla para avançar.
			if (pressedKey) {
				ds_queue_dequeue(global.messageStack);
			}
		} else if (array_length(actions) > 1) {
			// Selecionar ação
			selectedAction += sign(downKey - upKey);
			selectedAction = uc_wrap(selectedAction, 0, array_length(actions));
				
			// Confirmar
			if (pressedKey) {
				actions[selectedAction].callback();
			}
		} else {
			// Retornar
			if (canReturn && cancelKey) {
				ds_stack_pop(global.viewStack);	
			}
		}
	}
	
	drawBackground = function() {
		// Desenhar plano de fundo
		var _c1 = c_navy;
		var _c2 = c_navy;
		draw_rectangle_color(0, 0, global.guiWidth, global.guiHeight, _c1, _c1, _c2, _c2, false);
	}
	
	drawHeader = function() {
		// Desenhar Header Bar
		draw_rectangle_color(0, 0, global.guiWidth, 32, c_black, c_black, c_black, c_black, false);
		
		// Desenhar Header
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_font(fntHeader);
		var _hCol = headerColor;
		var _hCol2 = make_color_hsv(color_get_hue(headerColor), color_get_saturation(headerColor), color_get_value(headerColor) - 20);
		draw_text_color(global.guiWidth/2, 16, header, _hCol, _hCol, _hCol2, _hCol2, 1);	
	}
	
	drawFooter = function() {
		// Desenhar Footer Bar
		draw_rectangle_color(0, global.guiHeight - 32, global.guiWidth, global.guiHeight, c_black, c_black, c_black, c_black, false);
		
		// Desenhar Footer
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_font(fntHeader);
		var _hCol = headerColor;
		var _hCol2 = make_color_hsv(color_get_hue(headerColor), color_get_saturation(headerColor), color_get_value(headerColor) - 20);
		
		if (canReturn) {
			draw_text_color(16, global.guiHeight - 16, "ESC - Voltar", _hCol, _hCol, _hCol, _hCol, 1);	
		}
	}
	
	mainDraw = function() {
		
	}
	
	draw = function() {
		// Limpar tela
		draw_clear_alpha(c_black, 0);
		
		drawBackground();
		
		drawHeader();
		
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
				var _x = 32;
				var _y = floor(global.guiHeight * 2 / 3);
				var _spac = 28;
				_item.highlighted = selectedAction == _index;
				_item.draw(_x, _y + _index * _spac);
			}, 0, array_length(actions));
		}
		
		mainDraw();
		
		drawFooter();
	}
}

function InventoryView() : View() constructor {
	header = "Inventory";
	
	canReturn = true;
	
	mainDraw = function() {
		draw_set_halign(fa_center);
		draw_text(global.guiWidth/2, 100, "desenhando inventario");
	}
};