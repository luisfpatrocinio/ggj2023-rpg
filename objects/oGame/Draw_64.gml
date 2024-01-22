/// @description 
var gui_width = global.guiWidth;
var gui_height = global.guiHeight;
display_set_gui_size(gui_width, gui_height);

player.drawInfo(gui_width/2, gui_height * 3/4);

enemiesNumber = array_length(enemies);
spac = 240;

// Calcula a largura total ocupada pelos inimigos
var totalWidth = (enemiesNumber - 1) * spac;

// Posiciona o primeiro inimigo no centro da tela
enemiesStartX = global.guiWidth / 2 - totalWidth / 2;

// Itera sobre os inimigos
array_foreach(enemies, function(_item, _index) {
    var _x = enemiesStartX + spac * _index;
    _item.drawInfo(_x, 240);
});

// Desenhar a view atual:
var _view = ds_stack_top(global.viewStack);
if (!is_undefined(_view)) {
	_view.draw();
}