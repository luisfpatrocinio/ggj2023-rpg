/// @description 
global.viewStack = ds_stack_create();

function Entity() constructor {
	// Atributos:
	name = "";
	level = 0;
	hpMax = 10;
	hp = hpMax;
	mpMax = 10;
	mp = mpMax;
	attack = 0;
	defense = 0;
	
	// Métodos:
	toString = function() {
		return "Nome: " + name + "\nNível: " + string(level) + "\nVida: " + string(hp) + "/" + string(hpMax) + "\nMana: " + string(mp) + "/" + string(mpMax) + "\nAtaque: " + string(attack) + "\nDefesa: " + string(defense);	
	}
	
	drawInfo = function() {
		draw_set_font(fntGame);
		draw_set_color(c_black);
		draw_set_halign(fa_left);
		draw_text(x, y, toString());
	}
	
	init = function() {
		hp = hpMax;
		mp = mpMax;
	}
	
	takeDamage = function(amount) {
		hp -= amount;
		if (hp < 0) hp = 0;
		addMessageToStack(string("{0} recebeu {1} de dano!", name, amount));
	}
}

function Player() : Entity() constructor {
	expPoints = 0;
	
	
	
	drawInfo = function(x, y) {
		draw_set_font(fntGame);
		draw_set_color(c_black);
		draw_set_halign(fa_center);
		var _str = string("", name, level, );
		draw_text(x, y, toString());
	}
}

function Enemy() : Entity() constructor {
	sprite = sMimic;
	
	drawInfo = function(x, y) {
		draw_sprite(sprite, 0, x, y);
		
		draw_set_font(fntGame);
		draw_set_color(c_black);
		draw_set_halign(fa_center);
		var _str = string("Nome: {0}\nNível: {1}", name, level);
		draw_text(x, y, _str);
	}
}

player = new Player();
player.name = "Patrocinio";
player.level = 1;

enemies = [];

var _startView = new View();
	_startView.header = "View de testes.";
	_startView.actions = [
		new Action("Explorar", function() {
			addMessage("Você está explorando.");
			if (irandom(3) == 0) {
				addMessage("Opa deu sorte hein.");
			}
		}),
		new Action("Sair", function() {
			addMessage("Saindo...");	
		})
	];
ds_stack_push(global.viewStack, _startView);
