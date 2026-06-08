function entity_damage(_team, _number, _damage) {
	with(obj_characters) {
		var _teams = [
			team1,
			team2
		]
				
		if _team >= 0 and _number >= 0 {
			with(_teams[_team][_number]) {
				hp -= _damage
			}
		}
	}
}