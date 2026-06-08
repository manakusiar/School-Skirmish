//Teams
team1 = [
	-4,
	-4,
	new character_monster(),
	new character_monster6(),
]
team2 = [
	-4,
	new base_character(),
	new base_character(),
	new base_character(),
]


//Prepare entities
global.nearest_entity = -4
global.entity_selection_range = 64


//Set base positions
positions = [
	[[0,0],[0,0],[0,0],[0,0]],
	[[0,0],[0,0],[0,0],[0,0]]
]
var _base_x = room_width/4
var _base_y = room_height/2

var _teams = [
	team1,
	team2
]
for (var n = 0; n < array_length(_teams); ++n) {
	if n = 1 _base_x = room_width - _base_x //Base x
	
	var _len = array_length(_teams[n])
    for (var i = 0; i < _len; ++i) {
		var _size = 2
		var _w = sprite_get_width(spr_bottom) * _size 
		var _side = 1 - 2 * (n = 1)
			
		var _x = _base_x + (i * _w - _w * _len / 2) * _side
		var _y = _base_y
		
		positions[n][i][0] = _x
		positions[n][i][1] = _y
	}
}


//Next turn actions
new_turn = {
	is_new : 0,
	
	team : 0,
	number : 0,
	moves : 0,
	
	cooldown : 0,
	cooldown_max : 60
}

function start_next_turn() {
	new_turn.is_new = 1
}

function next_turn(_team, _number, _is_again) {
	var _teams = [
		team1,
		team2
	]
	
	with(_teams[_team][_number]) {
		if countdown <= 1 {
			action.ability(_team, _number)
					
			if not _is_again {
				action = new actions[irandom(array_length(actions) - 1)]()
				countdown = action.countdown_max
			}
		} else {
			countdown -= 1
		}
	}
}