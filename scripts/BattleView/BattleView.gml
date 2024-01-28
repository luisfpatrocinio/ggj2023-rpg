///@func startBattle(_enemiesArray)
///@desc Inicia uma batalha com os inimigos fornecidos
///@param _enemiesArray {Array<Enemy>} Array com inimigos
function startBattle(_enemiesArray) {
	enemies = _enemiesArray;
	
	var _battleView = new BattleView();
	if (is_array(enemies)) {
		_battleView.enemies = enemies;
	} else {
		_battleView.enemies = [enemies];
	}
	pushView(_battleView);
}


///@func BattleView()
///@desc Tela de Batalha
function BattleView() : View() constructor {
	
	// Array<Enemy>
	enemies = [];
	
	selectedEnemy = 0;
	selectingEnemy = false;
	confirmedEnemy = -1;
	
	header = "BATALHA";
	
	init = function() {
		actions = [
			new Action("Atacar", function() {
				getActualView().selectingEnemy = true;
			}),
			new Action("Itens", function() {
				pushView(new InventoryView());
			}),
			new Action("Fugir", function() {
				getActualView().popThisView();
			}),
		];
	}
	
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
	
	mainStep = function() {
		getInput();
		
		var _enemiesNmb = array_length(enemies);
		if (selectingEnemy && _enemiesNmb > 0) {
			actions = [];
			var _xAxis = sign(rightKey - leftKey);
			selectedEnemy += _xAxis;
			selectedEnemy = uc_wrap(selectedEnemy, 0, _enemiesNmb);
			if (_xAxis != 0) {
				playSFX(sndCursor);	
			}
			
			if (canInput() && pressedKey && confirmedEnemy == -1) {
				show_debug_message($"Confirmando ataque no inimigo: {selectedEnemy}");
				playSFX(sndConfirm);	
				confirmedEnemy = selectedEnemy;
				selectingEnemy = false;
				
				addMessage($"Você atacou o {enemies[confirmedEnemy].name}.");
				scheduleAction(function() {
					confirmedEnemy = -1;
					init();
				})
			}
		}
	}
	
	mainDraw = function() {		
		enemiesNumber = array_length(enemies);
		spac = 240;
		
		// Desenhar informações dos inimigos
		// Calcula a largura total ocupada pelos inimigos
		var totalWidth = (enemiesNumber - 1) * spac;

		// Posiciona o primeiro inimigo no centro da tela
		enemiesStartX = global.guiWidth / 2 - totalWidth / 2;
		
		array_foreach(enemies, function(_item, _index) {
			var _x = enemiesStartX + spac * _index;
			
			if (selectingEnemy && selectedEnemy == _index) {
				draw_circle_color(_x, 240, 100, c_lime, c_lime, false);	
			}
			
			drawEnemyInfo(_item, _x, 240);
		});
		
		
	}
}