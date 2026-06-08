
function nearest_entity(_x, _y){
	var _pos = obj_characters.positions
	
	var _max_dis = -4
	var _team = -4
	var _num = -4
	var _final_x = -4
	var _final_y = -4
	for (var n = 0; n < 2; ++n) {
	
		var _len = 4
	    for (var i = 0; i < _len; ++i) {
			var _x1 = _pos[n][i][0]
			var _y1 = _pos[n][i][1]
			
			var _dis = point_distance(_x,_y,_x1,_y1)
			if _max_dis > _dis or _max_dis = -4{
				_team = n
				_num = i
				
				_max_dis = _dis
				_final_x = _x1
				_final_y = _y1
			}
		}
	}
	
	return {
		team : _team, 
		number : _num, 
		distance : _max_dis,
		x : _final_x,
		y : _final_y
	}
}

function nearest_entity_is_selected() {
	with(obj_characters) {
		var _near = global.nearest_entity
		var _teams = [
			team1,
			team2
		]

		if _near.distance < global.entity_selection_range and _teams[_near.team][_near.number] != -4 {
			return true
		} else {
			return false
		}
	}
}