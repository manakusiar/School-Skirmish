function base_character() constructor {
	//Base values
	sprite_index = spr_monster1
	image_index = 0
	var _range_speed = 1
	image_speed = 1 + random_range(-_range_speed,_range_speed)
	
	image_xscale = 1
	image_yscale = 1
	image_angle = 0
	image_alpha = 1
	image_blend = c_white
	
	x = 0
	y = 0
	hspd = 0
	vspd = 0
	hacc = 0
	vacc = 0
	
	
	//Statistics
	max_hp = 10
	hp = max_hp
	hp_last = hp
	
	moves = 1
	damage = 4
	
	knockback = 5
	
	//Step
	attack = 0
	attack_wait = 0
	function step(_team, _number) {
		//Movement
		vspd += 1
		x = x*0.6
		
		if y + vspd >= 0 {
			y = 0
			vspd = 0
			vacc = 0
		}
		
		var _reduc = 0.95
		hspd += hacc
		vspd += vacc
		hacc *= _reduc
		vacc *= _reduc
		
		x += hspd
		y += vspd 
		hspd *= _reduc
		vspd *= _reduc
		
		
		//Attack
		if attack_wait <= 0 {
			if attack {
				attack = 0
				
				var _team_other = (_team = 0)
				var _num = entity_closest_center(_team_other)
				entity_damage(_team_other, _num, damage)
				
				audio_play_sound(snd_attack,0,false)
				
				effect_new(effect_slash, _team_other, _num)
			}
		} else {
			attack_wait -= 1
		}
		
		
		//Hp last
		if hp_last != hp {
			hspd  = -image_xscale * knockback
			hp_last = hp
		}
	}
	
	
	//Actions
	actions = [
		function() constructor {
			countdown_max = 1
			time = 20
			
			ability = function(_team, _number) {
				with(obj_characters) {
					var _teams = [
						team1,
						team2
					]
					
					with(_teams[_team][_number]) {
						vspd -= 10
						attack = 1
						attack_wait = action.time
					}
				}
			}
		}
	]
	
	action = new actions[irandom(array_length(actions) - 1)]()
	
	countdown = action.countdown_max
}

function character_monster() : base_character() constructor {
	sprite_index = spr_monster2
	
	//Statistics
	max_hp = 6
	hp = max_hp
	hp_last = hp
	
	moves = 2
	damage = 3
	
	actions = [
		function() constructor {
			countdown_max = 1
			time = 20
			
			ability = function(_team, _number) {
				with(obj_characters) {
					var _teams = [
						team1,
						team2
					]
					
					with(_teams[_team][_number]) {
						vspd -= 6
						attack = 1
						attack_wait = action.time
					}
				}
			}
		}
	]
	
	action = new actions[irandom(array_length(actions) - 1)]()
	countdown = action.countdown_max
}

function character_monster6() : base_character() constructor {
	sprite_index = spr_monster6
	
	//Statistics
	max_hp = 25
	hp = max_hp
	hp_last = hp
	
	moves = 1
	damage = 8
	
	knockback = 2
	
	
	function step(_team, _number) {
		//Movement
		vspd += 1
		x = x*0.6
		
		if y + vspd >= 0 {
			y = 0
			vspd = 0
			vacc = 0
		}
		
		var _reduc = 0.95
		hspd += hacc
		vspd += vacc
		hacc *= _reduc
		vacc *= _reduc
		
		x += hspd
		y += vspd 
		hspd *= _reduc
		vspd *= _reduc
		
		
		//Attack
		if attack_wait <= 0 {
			if attack {
				attack = 0
				
				var _team_other = (_team = 0)
				var _num = entity_closest_center(_team_other)
				entity_damage(_team_other, _num, damage)
				
				audio_play_sound(snd_attack_heavy,0,false)
				
				effect_new(effect_slash, _team_other, _num)
			}
		} else {
			attack_wait -= 1
		}
		
		
		//Hp last
		if hp_last != hp {
			hspd  = -image_xscale * knockback
			hp_last = hp
		}
	}
	
	
	actions = [
		function() constructor {
			countdown_max = 3
			time = 20
			
			ability = function(_team, _number) {
				with(obj_characters) {
					var _teams = [
						team1,
						team2
					]
					
					with(_teams[_team][_number]) {
						hspd += 10 * image_xscale
						attack = 1
						attack_wait = action.time
					}
				}
			}
		}
	]
	
	action = new actions[irandom(array_length(actions) - 1)]()
	countdown = action.countdown_max
}