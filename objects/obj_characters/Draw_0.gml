global.nearest_entity = nearest_entity(mouse_x,mouse_y)


////Draw back
//var _w = 22
//var _h = 1
//var _x = room_width/2 
//var _y = room_height/2

//draw_sprite_ext(spr_transparent,0,_x,_y,_w,_h,0,c_white,1)


//Draw characters
var _base_x = room_width/4
var _base_y = room_height/2

var _teams = [
	team1,
	team2
]

for (var n = 0; n < array_length(_teams); ++n) {
	
	var _len = array_length(_teams[n])
    for (var i = 0; i < _len; ++i) {
		
		var _size = 2
		var _x = positions[n][i][0]
		var _y = positions[n][i][1]
		
		//With every entity
		if is_struct(_teams[n][i]) {
		    with(_teams[n][i]) {
				
				#region Draw character
				
				draw_sprite_ext(sprite_index,image_index,_x + x,_y + y,_size * image_xscale,_size * image_yscale, image_angle, image_blend, image_alpha)
	
				#endregion
				
				
				#region Draw Bars and effects
				
				var _dis = 28
				var _hp_x = _x - _dis
				var _hp_y = _y + sprite_get_height(sprite_index)
				var _hp = hp / max_hp
				
				var _color = c_red
				for (var j = 0; j < ceil(_hp); ++j) {
					draw_set_color(_color)
				    draw_line_width(_hp_x,_hp_y,_hp_x + _dis * 2 * min(_hp - j, 1),_hp_y,12)
					
					var _hue  = color_get_hue(_color) + 20
					var _saturation  = color_get_saturation(_color)
					var _value  = color_get_value(_color)
					_color = make_color_hsv(_hue,_saturation,_value)
				}

				draw_set_color(c_white)
				draw_text_transformed(_x,_hp_y-1,string(hp) + " / " + string(max_hp),1,1,0)
				
				
				draw_set_font(fnt_big_pixel)
				draw_text_transformed(_x,_y-sprite_get_height(sprite_index)*2,countdown,1,1,0)
				draw_set_font(fnt_pixel)
				
				#endregion
	
				
				#region Animations	
	
				image_index += sprite_get_speed(sprite_index) / 60 * image_speed
				var _image_number = sprite_get_number(sprite_index)
				if image_index > _image_number {
					image_index = 0
				}
				image_index = image_index % _image_number
				
				#endregion
			}
		}
	}
}