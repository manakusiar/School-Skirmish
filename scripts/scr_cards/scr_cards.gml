function base_card() constructor {
	//Position
	x = room_width/10
	y = room_height * 0.85
	x_last = 0
	y_last = 0
	x_go = 0
	y_go = 0
	
	arrow = 0
	
	//Base values
	image_xscale = 1
	image_yscale = 1
	scale_go = 1
	image_angle = 0
	
	sprite_index = spr_cards_back
	
	
	//Click Values
	click_cooldown = 0
	clicked = 0
	info = 0
	name = choose("Base Card","Hello","Test Name")
	description = "This is the base card of this game."
	
	
	//Statistics
	atk = irandom(9)
	def = irandom(9)
	cost = [0,0,0,0]
	
	badges = [
		
	]
	summon = base_character
	
	
	//Surface and drawing
	var _w = sprite_get_width(sprite_index)
	var _h = sprite_get_height(sprite_index)
	surf = surface_create(_w*1.5,_h*1.5)
	
	//Draw card onto own surface
	function card_draw() {
		var _w = sprite_get_width(sprite_index)
		var _h = sprite_get_height(sprite_index)
		
		var _dir = 360 - image_angle
		var _x = x + lengthdir_x(_w/2,_dir) - _w * image_xscale
		var _y = y + lengthdir_y(_h/2,_dir) - _h/2 * image_yscale
		draw_surface_ext(surf,_x,_y,image_xscale,image_yscale,image_angle,c_white,1)
	}
	
	
	//Run all the badges functions
	function run_badges() {
		for (var i = 0; i < array_length(badges); ++i) {
		    var _badge = badges[i]
			global.badges[? badges[i][0]].ability(badges[i][1])
		}
	}
	
	
	//Check if can play card
	function can_play() {
		var _can_play = true
		for (var i = 0; i < array_length(badges); ++i) {
		    var _badge = badges[i]
			if global.badges[? badges[i][0]].check(badges[i][1]) = false {
				_can_play = false
			}
		}
		return _can_play
	}
	
	
	//Run what happens on play
	function on_play() {
		return run_badges()
	}
}

function health_card() : base_card() constructor {
	atk = 0
	def = 0
	cost = [0,0,1,1]
	
	arrow = 1
	
	name = "Health Card"
	description = "This card heals"
	
	sprite_index = spr_card_heart
	
	badges = [
		["heal",4]
	]
}

function iron_coin_card() : base_card() constructor {
	atk = 0
	def = 0
	cost = [0,0,0,0]
	
	name = "Coin Card"
	description = "This card gives an iron coin"
	
	sprite_index = spr_card_coin_iron
	
	badges = [
		["iron",3]
	]
}

function silver_coin_card() : base_card() constructor {
	atk = 0
	def = 0
	cost = [0,0,0,0]
	
	name = "Coin Card"
	description = "This card gives an silver coin"
	
	sprite_index = spr_card_coin_silver
	
	badges = [
		["silver",2]
	]
}

function gold_coin_card() : base_card() constructor {
	atk = 0
	def = 0
	cost = [0,0,0,0]
	
	name = "Coin Card"
	description = "This card gives an gold coin"
	
	sprite_index = spr_card_coin_gold
	
	badges = [
		["gold",1]
	]
}

function mana_card() : base_card() constructor {
	atk = 0
	def = 0
	cost = [0,0,0,0]
	
	name = "Trade Card"
	description = "This card gives you mana"
	
	sprite_index = spr_card_mana
	
	badges = [
		["trade",2]
	]
}

function antidote_card() : base_card() constructor {
	atk = 0
	def = 0
	cost = [0,0,0,1]
	
	name = "Roid Card"
	description = "This card lets you draw cards"
	
	sprite_index = spr_card_antidote
	
	badges = [
		["draw",2]
	]
}
	
function monster_card() : base_card() constructor {
	atk = 0
	def = 0
	cost = [0,0,2,0]
	
	arrow = 1
	
	name = "Monster Card"
	description = "This card summons a monster"
	
	sprite_index = spr_card_monster1
	
	badges = [
		["summon", base_character]
	]
}
	
function monster2_card() : base_card() constructor {
	atk = 0
	def = 0
	cost = [0,0,0,4]
	
	arrow = 1
	
	name = "Monster Card"
	description = "This card summons a monster"
	
	sprite_index = spr_card_monster2
	
	badges = [
		["summon", character_monster]
	]
}

function monster6_card() : base_card() constructor {
	var _stats = new character_monster6()
	atk = _stats.damage
	def = _stats.hp
	cost = [0,1,1,1]
	
	arrow = 1
	
	name = "Tanky Monster Card"
	description = "This card summons a monster"
	
	sprite_index = spr_card_monster6
	
	badges = [
		["summon", character_monster6]
	]
}
	
function attack_card() : base_card() constructor {
	atk = 4
	def = 0
	cost = [0,0,0,1]
	
	arrow = 1
	
	name = "Attack Card"
	description = "This card attacks"
	
	sprite_index = spr_card_attack
	
	badges = [
		["attack", {
			damage : atk,
			multaplier : 1
		}]
	]
}