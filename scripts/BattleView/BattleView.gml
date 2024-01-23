///@func BattleView()
///@desc Tela de Batalha
function BattleView() : View() constructor {
	
	// Array<Enemy>
	enemies = [];
	
	header = "BATALHA";
	
	drawPlayerInfo = function() {
		
	}
	
	drawEnemyInfo = function(enemy, x, y) {
		draw_sprite(enemy.sprite, 0, x, y);
		
		draw_set_font(fntGame);
		draw_set_color(c_black);
		draw_set_halign(fa_center);
		var _str = string("Nome: {0}\nNível: {1}", enemy.name, enemy.level);
		draw_text(x, y, _str);
	}
	
	mainDraw = function() {		
		enemiesNumber = array_length(enemies);
		spac = 240;
		
		// Calcula a largura total ocupada pelos inimigos
		var totalWidth = (enemiesNumber - 1) * spac;

		// Posiciona o primeiro inimigo no centro da tela
		enemiesStartX = global.guiWidth / 2 - totalWidth / 2;

		// Itera sobre os inimigos
		array_foreach(enemies, function(_item, _index) {
		    var _x = enemiesStartX + spac * _index;
			drawEnemyInfo(_item, _x, 240);
		});
	}
}