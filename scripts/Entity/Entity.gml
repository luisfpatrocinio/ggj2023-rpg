///@func Entity
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
	
	spd = 0;
	
	// Métodos:
	toString = function() {
		return "Nome: " + name + "\nNível: " + string(level) + "\nVida: " + string(hp) + "/" + string(hpMax) + "\nMana: " + string(mp) + "/" + string(mpMax) + "\nAtaque: " + string(attack) + "\nDefesa: " + string(defense) + "\nSpeed: " + string(spd);	
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
		addMessage(string("{0} recebeu {1} de dano!", name, amount));
	}
}