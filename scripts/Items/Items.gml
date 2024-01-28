///@func countItems(_item)
///@desc Retorna a quantidade de itens no inventário
///@param _item {Item} Item desejado
function countItems(_item) {
	try {
		if (!is_instanceof(_item, Item)) throw("Item errado.");
		var _itemId = _item.id;
		var _qnt = 0;
		for (var k = 0; k < array_length(global.inventory); k++) {
			if (global.inventory[k].id == _itemId) {
				_qnt++;	
			}
		}
		
		return _qnt
	} catch (_err) {
		show_debug_message(_err.message);
	}
}

///@func obtainItem(_item)
///@desc Obtém um item determinado
///@param _item {Item} item a ser obtido.
///@param _qnt {integer} quantidade a ser obtida. (opcional)
function obtainItem(_item, _qnt = 1) {
	repeat(_qnt) {
		array_push(global.inventory, _item);
	}
}

///@func Item()
///@desc Constructor do Item
function Item() constructor {
	id = "";
	name = "Item";
	
	callback = function() {
		playSFX(sndGroan4);	
	}
	
	toString = function() {
		return $"Item ID: {id}, name: {name}.";
	}
}

function Potion() : Item() constructor {
	id = "potion";
	name = "Potion";	
}

function HiPotion() : Item() constructor {
	id = "hiPotion";
	name = "Hi-Potion";	
}