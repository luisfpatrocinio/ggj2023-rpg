///@func Enemy()
function Enemy() : Entity() constructor {
	sprite = sMimic;
}

function Mushroom() : Enemy() constructor {
	hpMax = 20;
	hp = hpMax;
	
	attack = 4;
	defense = 3;
	
	spd = 2;
	
	name = "Mushroom";
	sprite = sMushroom;
}