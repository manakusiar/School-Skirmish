function entity_closest_center(_team){
	with(obj_characters) {
		var _teams = [
			team1,
			team2
		]
		var _team_cur = _teams[_team]
					
		var _len = array_length(_team_cur)
		var _closest = _len*_team
		for (var i = 0; i < _len; ++i) {
		    var _n = _len - i - 1
			if is_struct(_team_cur[_n]) {
				return _n
			}
		}
		
		return -4
	}
}