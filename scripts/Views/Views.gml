///@func scheduleAction(_function)
///@param _function {function}
function scheduleAction(_function) {
	ds_stack_top(global.viewStack).functionToCall = _function;
}

///@func pushView(_view)
///@param _view {View} View to be added
function pushView(_view) {
	ds_stack_push(global.viewStack, _view);	
}

///@func View()
///@desc Tela a ser exibida e adicionada na global.viewStack.
function View() constructor {
	initialized = false;
	
	selectedAction = 0;
	actions = [];
	header = "";
	
	headerColor = c_white;
	
	canReturn = false;
	
	functionToCall = undefined;
	
	backgroundStruct = {
		bgColor: c_navy,
		textColor: c_black
	}
	
	setupBackground = function(_struct) {
		var _names = variable_struct_get_names(_struct);
		for (var i = 0; i < array_length(_names); i++) {
			var _value = variable_struct_get(_struct, _names[i]);
			variable_struct_set(backgroundStruct, _names[i], _value);
		}
	}
	
	popThisView = function() {
		instance_create_depth(0, 0, 0, oTransitionCut);
		ds_stack_pop(global.viewStack);	
		ds_stack_top(global.viewStack).initialized = false;
	}
	
	init = function() {
		initialized = false;	
	}
	
	step = function() {
		if (!initialized) {
			init();
			initialized = true;
		}
		getInput();
		
		// Caso tenhamos mensagem:
		if (ds_queue_head(global.messageQueue) != undefined) {
			// Apertar tecla para avançar.
			if (pressedKey) {
				ds_queue_dequeue(global.messageQueue);
				
				// Ao fim da mensagem, adicionar à stack a view guardada em memória, caso haja.
				if (ds_queue_size(global.messageQueue) <= 0) {
					if (!is_undefined(global.viewToBePushed)) {
						instance_create_depth(0, 0, 0, oTransitionCut);
						ds_stack_push(global.viewStack, global.viewToBePushed);	
						global.viewToBePushed = undefined;
					}
				}
			}
		} else if (!is_undefined(functionToCall)) {
			functionToCall();
			functionToCall = undefined;
		} else if (array_length(actions) > 1) {
			// Selecionar ação
			var _yAxis = sign(downKey - upKey)
			selectedAction += _yAxis;
			selectedAction = uc_wrap(selectedAction, 0, array_length(actions));
			if (_yAxis != 0) {
				Audio(sndCursor);
				actions[selectedAction].selectedTimer = 4;
			}
			
				
			// Confirmar
			if (pressedKey) {
				Audio(sndConfirm);
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
		var _c1 = backgroundStruct.bgColor;
		var _c2 = backgroundStruct.bgColor;
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
		if (!is_undefined(functionToCall) && ds_queue_size(global.messageQueue) <= 0) {
			var _c = c_black;
			draw_rectangle_color(0, 0, global.guiWidth, global.guiHeight, _c, _c, _c, _c, false);
			return
		}
		
		drawBackground();
		
		drawHeader();
		
		// Caso tenhamos mensagem:
		if (ds_queue_size(global.messageQueue) > 0) {
			drawMessage(ds_queue_head(global.messageQueue));
			
			if (ds_queue_size(global.messageQueue) > 1) {
				draw_set_color(c_orange);
				draw_text(global.guiWidth/2, global.guiHeight - 64, "[NEXT]");	
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
	
	setupBackground({
		bgColor: c_dkgray,
		textColor: c_white
	}) 
	
	mainDraw = function() {
		draw_set_halign(fa_center);
		draw_set_color(backgroundStruct.textColor);
		draw_text(global.guiWidth/2, 100, "~desenhando inventario~");
	}
};

///@func CutsceneView(_textsArray)
///@param _textsArray {string[]}
function CutsceneView(_textsArray) : View() constructor {
	header = "";
	
	actualTextIndex = 0;
	texts = _textsArray;
	
	textAlpha = 0;
	timerToAdvance = 240;
	
	step = function() {
		textAlpha = approach(textAlpha, 1 - (timerToAdvance < 0), 1 / room_speed * 2);
		var _text = texts[actualTextIndex];
		timerToAdvance--;
		if (timerToAdvance < 0) {
			if (actualTextIndex < array_length(texts) - 1) {
				if (textAlpha <= 0) {
					actualTextIndex++;
					textLen = 0;
					timerToAdvance = 240;
				}
			} else {
				popThisView();
			}
		} else {
			getInput();
			if (pressedKey) timerToAdvance = 0;
		}
	}
	
	mainDraw = function() {
		var _text = texts[actualTextIndex];
		draw_set_alpha(textAlpha);
		draw_set_color(backgroundStruct.textColor);
		draw_text_ext(global.guiWidth/2, global.guiHeight/2, _text, 20, global.guiWidth * 0.80);
		draw_set_alpha(1);
	}
}