var _teams = [
	team1,
	team2
]

for (var n = 0; n < array_length(_teams); ++n) {
	
	var _len = array_length(_teams[n])
    for (var i = 0; i < _len; ++i) {
		
		var _size = 2
		var _side = 1 - 2 * (n = 1)
		var _x = positions[n][i][0]
		var _y = positions[n][i][1]
		
		//With every entity
		if is_struct(_teams[n][i]) {
		    with(_teams[n][i]) {
				image_xscale = _side
				
				step(n, i)
			}

			if _teams[n][i].hp <= 0 {
				_teams[n][i] = -4
			}
		}
	}
}


//Next turn
with(new_turn) {
	if is_new = 1 {
		var _index = _teams[team, number]
		var _is_entity = is_struct(_index)
		
		var _moves = 1
		if _is_entity _moves = _index.moves + 1
		
		if cooldown <= 0 {
			moves += 1
			
			var _is_again = (moves < _moves-1)
			if _is_entity {
				var _team = team, _number = number
				with(other) {
					next_turn(_team, _number, _is_again)
				}
			}
		
			if not _is_again {
				moves = 0
				
				var _len = 3
				number += 1
				if number > _len {
					team += 1
					number = 0
			
					if team > 1 {
						team = 0
						is_new = 0
					}
				}
			}
			
			if _is_entity {
				cooldown_max = _index.action.time + 10
				
				cooldown = cooldown_max
			}
		} else {
			cooldown -= 1
		}
	}
}