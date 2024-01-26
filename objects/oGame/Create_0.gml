/// @description 
live_auto_call 
global.viewStack = ds_stack_create();
global.viewToBePushed = undefined;

// História
global.creatureFound = false;

// Items
global.inventory = [];





player = new Player();
player.name = "Patrocinio";
player.level = 1;

enemies = [];

// Cria tela de testes: Floresta Debug
var _startView = new View();
	_startView.header = "Floresta Debug";
	_startView.setupBackground({
		bgColor: make_color_rgb(0, 140, 0)
	});
	_startView.init = function() {
		ds_stack_top(global.viewStack).actions[0].name = global.creatureFound ? "Visitar Criatura Estranha" : "Explorar"
	}
	_startView.actions = [
		new Action("Explorar", function() {
			addMessage("Você está explorando.");
			
			var mensagens = [
		        "Você caminha entre as árvores de bits da Floresta Debug. Os ramos formam padrões estranhos e intrigantes.",
		        "Ao se aprofundar na Floresta Debug, você encontra um caminho de linhas de código. Será que é seguro seguir por aqui?",
		        "Entre os arbustos de variáveis, você avista um coelho peculiar. Ele parece estar fazendo loop em torno de um ponto indefinido.",
		    ];
			
			var _randInd = 1;
			addMessage(mensagens[_randInd]);
			
			if (_randInd == 1) {
				var _nextView = new View();
					_nextView.header = "Profundezas da Floresta Debug";
					_nextView.init = function() {
						if (global.creatureFound) {
							playSFX(sndGroan4);
						}
					}
					_nextView.setupBackground({
						bgColor: make_color_rgb(0, 100, 0),
						textColor: c_orange
					});
					_nextView.mainDraw = function() {
						if (global.creatureFound) {
							draw_sprite(sWisp_View1, 0, global.guiWidth/2, global.guiHeight/2);
						}
					}
					_nextView.actions = [
						new Action("Explorar", function() {
							if (!global.creatureFound) {
								addMessage("O que é isso?");
								addMessage("Uma criatura estranha surge.");
								ds_stack_top(global.viewStack).functionToCall = function() {
									ds_stack_top(global.viewStack).initialized = false;
									global.creatureFound = true;	
								}
							} else {
								addMessage("O monstro inicia um ataque!");
								scheduleAction(function() {
									var _battleView = new BattleView();
										_battleView.enemies = [new Mushroom()];
									pushView(_battleView);
								});
							}
						}),
						new InventoryAction(),
						new Action("Sair", function() {
							addMessage("Realmente é melhor voltar para o caminho seguro.");	
							ds_stack_top(global.viewStack).functionToCall = function() {
								ds_stack_top(global.viewStack).popThisView();
							}
						})
					];
					global.viewToBePushed = _nextView;
			
			}
		}),
		new InventoryAction()
	];
ds_stack_push(global.viewStack, _startView);

// Cutscenes:
var _historiaFlorestaDebug = [
    "Numa dimensão de algoritmos e pixels, surge a Floresta Debug, um espaço mágico de árvores binárias e caminhos de código.",
    "Este é um lugar temporário, um mero esboço, onde cada árvore guarda segredos de bugs fictícios e desafios simulados.",
    "Aventure-se por entre os bits e bytes, sabendo que esta é uma terra de placeholders, aguardando a verdadeira magia da sua imaginação."
];
var _cutsceneView = new CutsceneView(_historiaFlorestaDebug);
	_cutsceneView.setupBackground({
		bgColor: make_color_rgb(0, 20, 0),
		textColor: c_ltgray
	});
ds_stack_push(global.viewStack, _cutsceneView);