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
	
	actingEntityNo = 0;
	
	header = "BATALHA";
	
	// Array ordenado que guarda as entidades que irão agir.
	battleQueue = [];
	
	// Fila de ações que acontecerão na fase de batalha	
	battleActions = ds_queue_create();
	
	init = function() {
		actingEntityNo = 0;
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
	
	///@func BattleAct(_entity)
	///@desc Executa a ação de batalha da entidade.
	///@param _entity {Entity}
	battleAct = function(_entity) {
		show_debug_message($"battleAct executado de {_entity.name}");
		
		actor = _entity;
		
		addMessage($"{actor.name} realiza sua ação: ");
		
		// Se a entidade for player:
		if (is_instanceof(actor, Player)) {
			var _target = enemies[confirmedEnemy];
			var _amount = actor.attack - _target.defense;	// TODO: Tornar isso uma função.
			_target.hp -= _amount;
			
			addMessage($"{_target.name} tomou {_amount} de dano!");
		}
		
		// Se a entidade for inimigo:
		if (is_instanceof(actor, Enemy)) {
			var _target = global.player;
			var _amount = actor.attack - _target.defense;
			_target.hp -= _amount;
			
			addMessage($"{_target.name} tomou {_amount} de dano!");
		}
		
	}
	
	
	///@func startBattleQueue()
	startBattleQueue = function() {
		show_debug_message("Inicializando fila de battle actions.");
		if (actingEntityNo < array_length(battleQueue)) {
			// Se for menor que 0, começar. Depois será preciso ajustar o valor inicial de -1 para 0. E voltar pra 0 no init.
			actingEntityNo = max(actingEntityNo, 0);
			var _entity = battleQueue[actingEntityNo];
			show_debug_message($"{actingEntityNo} - Vamos fazer um battleAct da entidade: {_entity.name}");
			battleAct(_entity);
			
			show_debug_message($"A função scheduleada é: {functionToCall}");
			
			scheduleAction(function() {
				getActualView().actingEntityNo++;
				show_debug_message($"Executando ação sheculeada. Novo valor de actingEntityNo: {getActualView().actingEntityNo}");
				getActualView().startBattleQueue();
			})
		} else {
			init();	
		}
	}
	
	
	///@func realizeBattle()
	///@desc Atualiza o battleQueue com as entidades da maior speed para menor.
	realizeBattle = function() {
		show_debug_message("Realizando batalha...");
		battleQueue = [];
		
		// Adiciona todos os inimigos no array
		for (var i = 0; i < array_length(enemies); i++) {
			array_push(battleQueue, enemies[i]);	
		}
		array_push(battleQueue, global.player);
		
		// Classifica o array a partir da speed de cada entity.
		array_sort(battleQueue, function(_a, _b) {
			return _a.spd < _b.spd;
		});
		
		// Iniciar ações.
		startBattleQueue();
	}
	
	///@func drawEnemyInfo(x, y)
	///@desc Desenha as informações do player
	///@param x {real}
	///@param y {real}
	drawPlayerInfo = function(x, y) {
		draw_text(x, y, global.player.toString());
	}
	
	///@func drawEnemyInfo(enemy, x, y)
	///@desc Desenha as informações do inimigo na tela
	///@param enemy {Enemy}
	///@param x {real}
	///@param y {real}
	drawEnemyInfo = function(enemy, x, y) {
		draw_sprite(enemy.sprite, 0, x, y);
		
		draw_set_font(fntGame);
		draw_set_color(c_black);
		draw_set_halign(fa_center);
		var _str = $"{enemy.name} nv{enemy.level}\nHP: {enemy.hp}/{enemy.hpMax}";
		draw_text(x, y, _str);
	}
	
	mainStep = function() {
		getInput();
		
		// Selecionar inimigo:
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
					realizeBattle();
					confirmedEnemy = -1;
					// init();
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
		
		drawPlayerInfo(global.guiWidth/2, global.guiHeight * 3/4);
	}
}