function base_character() constructor {
	sprite_index = spr_player
	image_index = 0
	
	var _range_speed = 1
	image_speed = 1 + random_range(-_range_speed,_range_speed)
	
	//Stats
	max_hp = 10
	hp = max_hp / 2
}