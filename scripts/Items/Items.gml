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
	
	toString = function() {
		return $"Item ID: {id}, name: {name}.";
	}
}

function TestItem() : Item() constructor {
	id = "testItem";
	name = "Item de Teste";	
}