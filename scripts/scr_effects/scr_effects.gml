function effect_base(_team, _number) constructor {
	team = _team
	number = _number
	
	image_alpha = 1
	
	function step(_num) {
		list_num = _num
	}
	
	function draw(_num) {
	
	}
	
	function destroy_self(_num) {
		with(obj_effects) {
			ds_list_add(destroy_effects,_num)
		}
	}
}

function effect_slash(_team, _number) : effect_base(_team, _number) constructor {
	
	function step(_num) {
		image_alpha *= 0.9
		if image_alpha < 0.05 {
			destroy_self(_num)
		}
	}
	
	function draw(_num) {
		var _team = team, _number = number
		if _team >= 0 and _number >= 0 {
			with(obj_characters) {
				var _x = positions[_team][_number][0]
				var _y = positions[_team][_number][1] - sprite_get_height(spr_monster1) / 2
			}
			
			draw_sprite_ext(spr_slash,sprite_get_number(spr_slash) * (1 - image_alpha),_x,_y,1,1,0,c_white,1)
		}
	}
}