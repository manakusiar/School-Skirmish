global.badges = ds_map_create()

//Heal
ds_map_add(global.badges,"heal",{
	ability : function(_power) {
		with(obj_characters) {
			var _teams = [
				team1,
				team2
			]
		
			var _near = global.nearest_entity
			with(_teams[_near.team][_near.number]) {
				hp += _power
			}
		}
	},
	
	check : function(_power) {
		return nearest_entity_is_selected()
	}
})

//Iron
ds_map_add(global.badges,"iron",{
	ability : function(_power) {
		other.coins[3] += _power
	},
	
	check : function(_power) {
		return true
	}
})
//silver
ds_map_add(global.badges,"silver",{
	ability : function(_power) {
		other.coins[2] += _power
	},
	
	check : function(_power) {
		return true
	}
})
//gold
ds_map_add(global.badges,"gold",{
	ability : function(_power) {
		other.coins[1] += _power
	},
	
	check : function(_power) {
		return true
	}
})
//diamond
ds_map_add(global.badges,"diamond",{
	ability : function(_power) {
		other.coins[0] += _power
	},
	
	check : function(_power) {
		return true
	}
})

//Draw
ds_map_add(global.badges,"draw",{
	ability : function(_power) {
		other.drawing += _power
	},
	
	check : function(_power) {
		return true
	}
})

//Trade
ds_map_add(global.badges,"trade",{
	ability : function(_power) {
		with(obj_cards) {
			var _len = array_length(coins)
			for (var i = 0; i < _len; ++i) {
				if i != 3 and coins[i] > 0 {
					coins[i] -= 1
					coins[i+1] += _power
				}
			}
		}
	},
	
	check : function(_power) {
		with(obj_cards) {
			var _can = 0
			var _len = array_length(coins)
			for (var i = 0; i < _len; ++i) {
				if i != 3 and coins[i] > 0 {
					_can = 1
				}
			}
			return _can
		}
		
	}
})

//Summon
ds_map_add(global.badges,"summon",{
	ability : function(_power) {
		var _near = global.nearest_entity
		
		var _teams = [
			obj_characters.team1,
			obj_characters.team2
		]
		var _index = _teams[_near.team][_near.number]
		if not is_struct(_index) {
			with(obj_characters) {
				var _teams = [
					team1,
					team2
				]
				_teams[_near.team][_near.number] = new _power()
			}
		}
	},
	
	check : function(_power) {
		var _near = global.nearest_entity
		
		var _teams = [
			obj_characters.team1,
			obj_characters.team2
		]
		var _index = _teams[_near.team][_near.number]
		if not is_struct(_index) {
			return true	
		} else {
			return false
		}
	}
})

//Attack
ds_map_add(global.badges,"attack",{
	ability : function(_power) {
		with(obj_characters) {
			var _teams = [
				team1,
				team2
			]
		
			var _near = global.nearest_entity
			entity_damage(_near.team, _near.number, _power.damage)
				
			audio_play_sound(snd_attack,0,false)
				
			effect_new(effect_slash, _near.team, _near.number)
		}
	},
	
	check : function(_power) {
		return nearest_entity_is_selected()
	}
})