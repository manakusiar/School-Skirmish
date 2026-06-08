//Draw Money
var _len = array_length(coins_list)
var _x = room_width/32
var _y = room_height*0.5
for (var i = 0; i < _len; ++i) {
	var _len_list = ds_list_size(coins_list[i])
	var _len_coin = coins[i]
    repeat(abs(_len_list - _len_coin)) {
		_len_list = ds_list_size(coins_list[i])
		_len_coin = coins[i]
		if _len_list > _len_coin {
			ds_list_delete(coins_list[i], 0)
		} else if coins_cooldown <= 0 {
			ds_list_add(coins_list[i], new coin(_x + 16 * i,_y - 4*_len_list))
			coins_cooldown = coins_cooldown_max
		} else {
			coins_cooldown -= 1
		}
	}
}

draw_set_halign(fa_center)
draw_set_valign(fa_middle)

var _text_scale = 1
_x = room_width/32
_y = room_height*0.74

draw_sprite_ext(spr_transparent, 0, _x + 18, _y + 12, 2.5, 1, 0, c_white, 1)
for (var i = 0; i < array_length(coins); ++i) {
	
	
	_y = room_height*0.74
	var _coins = coins[i]
	var _text_height = string_height(string(_coins))
	
	draw_set_color(#14182E)
	draw_text_transformed(_x - 4,_y + _text_height*1.5,_coins = 0? "-" : _coins,_text_scale,_text_scale,0)
	draw_set_color(c_white)
	
	
	draw_sprite(spr_no_coin,0,_x - 4,_y + 4)
    for (var n = 0; n < _coins; ++n) {
		with(coins_list[i][| n]) {
			x = lerp(x, _x - 4, 0.1)
			y = lerp(y, _y + 4, 0.1)
			
			image_xscale = lerp(image_xscale, 1, 0.1)
			image_yscale = lerp(image_yscale, 1, 0.1)
			image_alpha = lerp(image_alpha, 1, 0.1)
			
			draw_sprite_ext(spr_coins_big,i,x,y,image_xscale,image_yscale,0,c_white,image_alpha)
			
			
			_y -= 4
		}
	}
	_x += 16
}


//Draw Cards as surface
var _decks = [
	cards,
	save,
	draw,
	discard
]
var _selected = selected
for (var n = 0; n < array_length(_decks); ++n) {
	var _index = _decks[n]
	_len = ds_list_size(_index)
	for (var i = 0; i < _len; ++i) {
		//if not (i = _selected and n = 0) {
		    with(_index[| i]) {
				var _w = sprite_get_width(sprite_index)
				var _h = sprite_get_height(sprite_index)
				if !surface_exists(surf) {
					surf = surface_create(_w*1.5,_h*1.5)
				}
			
				surface_set_target(surf)
			
				draw_clear_alpha(c_black, 0)
				draw_sprite_ext(sprite_index,0,_w/2,_h/2,1,1,0,c_white,1)

				//Texts
				draw_set_alpha(1)
				draw_set_color(#FFFEE6)
				draw_set_valign(fa_bottom)
				//draw_set_color(c_)
				draw_set_halign(fa_left)
				var _atk = atk = 0? "--" : string(atk)
				draw_text_transformed(16,floor(_h*0.7/2)*2,_atk,_text_scale,_text_scale,0)
			
				var _def = def = 0? "--" : string(def)
				draw_text_transformed(44,floor(_h*0.7/2)*2,_def,_text_scale,_text_scale,0)
			
				draw_set_valign(fa_top)
				var _roman = ["I","II","III","IV","V","VI","VII","VIII","IX","X"]
				var _base_y = 66
				for (var j = 0; j < array_length(badges); ++j) {
					var _num = badges[j][1]
					
					var _num_roman = ""
					if is_real(_num) and _num > 0 {
						_num_roman = _num > 0 and _num <= 10? _roman[_num-1] : string(_num)
					}
					
					var _text = string_upper(badges[j][0]) + " "  + _num_roman
					var _text_height = string_height(_text)
				    draw_text_transformed(6,_base_y + (_text_height-2)*j,_text,_text_scale,_text_scale,0)
				}
				
				
				//Draw cost		
				var _ammount = 0
				for (var h = 0; h < array_length(cost); ++h) 
					if cost[h] > 0 _ammount += 1
				
				//Distance
				var _dis = 16
				var _is_selected = (i = _selected and n = 0)
				if not _is_selected and _ammount > 2 {
					_dis = 6
				} else {
					_dis = 18 - max((_ammount-3)*2, 2)
				}
				
				_x = _w/2 - (_ammount - 1)/2 * _dis 
				_y = (_h - 3) + 4 * (array_length(badges) > 1 and _is_selected)
				for (var h = 0; h < array_length(cost); ++h) {
					var _cost = cost[h] 
					if _cost > 0 {
						draw_sprite_ext(spr_coins_simple,h,_x,_y,1,1,0,c_white,1)
						
						if _dis > 8 or h  = 3 {
							draw_set_valign(fa_top)
							draw_set_halign(fa_left)
							draw_set_color(c_black)
							draw_text_transformed(_x-2,_y-7,_cost,1,1,0)
							draw_set_color(c_white)
							draw_set_valign(fa_middle)
							draw_set_halign(fa_center)
						}
				
						_x += _dis
					}
				}
				
				draw_set_color(c_white)
				draw_set_halign(fa_center)
				draw_set_valign(fa_middle)
				draw_set_alpha(1)
			
			
				surface_reset_target()
			}
		//}
	}
	
	//Draw Cards in room
	for (var i = 0; i < _len; ++i) {
		if not (i = selected and n = 0) {
		    with(_index[| i]) {
				if n = 2 or n = 3 {
					draw_sprite_ext(spr_cards_back,0,x,y,image_xscale,image_yscale,image_angle,c_white,1)
				} else {
					card_draw()
				}
			}
		}
	}
}


//Draw selected Card
if selected != -4 {
	with(cards[| selected]) {
		
		//Draw arrow
		//if arrow = 1 and mouse_check_button(mb_left) {
		//	var _line = 32
		//	var _direction = 90
		//	var _near = global.nearest_entity
		//	_x = x
		//	_y = y
		
		//	var _go_x = mouse_x
		//	var _go_y = mouse_y
		//	var _entity_max_dis = global.entity_selection_range
		//	if _near.distance < _entity_max_dis {
		//		_go_x = _near.x
		//		_go_y = _near.y
				
		//		draw_rectangle(_go_x - _entity_max_dis / 2, _go_y,_go_x + _entity_max_dis / 2, _go_y - _entity_max_dis, true)
		//	}
		
		//	var _max = 40
		//	var _max_dis = point_distance(_x,_y,_go_x,_go_y)
		//	if _max_dis > 32 {
		//		for (var i = 0; i < _max; ++i) {
		//			var _width = 2
		//			var _x1 = _x, _y1 = _y
		//			var _dir = point_direction(_x,_y,_go_x,_go_y)
		//			var _dis = point_distance(_x,_y,_go_x,_go_y)
		//			_direction -= angle_difference(_direction,_dir)*(i/_max*4)
				
		//			if _dis < _line * 2 {
		//				_x += lengthdir_x(_dis,_direction)
		//				_y += lengthdir_y(_dis,_direction)
		//				draw_arrow(_x1,_y1,_x,_y,24)
		//				draw_line_width(_x1,_y1,_x,_y,_width)
		//				break
		//			} else {
		//				_x += lengthdir_x(_line,_direction)
		//				_y += lengthdir_y(_line,_direction)
		//				draw_line_width(_x1,_y1,_x,_y,_width)
		//			}
		//		}
		//	}
		//}
		
		//Draw card
		card_draw()
		
		if info = 1 {
			_x = room_width/2
			_y = room_height/3
			var _scale_name = 2
			//draw_set_font(fnt_big_pixel)
			draw_text_transformed(_x,_y,name,_scale_name,_scale_name,0)
			var _name_height = string_height(name)
			//draw_set_font(fnt_pixel)
			var _scale_desc = 1
			draw_text_ext_transformed(_x,_y + _name_height*_scale_name + 4,description,16,room_width/3,_scale_desc,_scale_desc,0)
		}
		
	}
}

draw_set_halign(fa_center)
draw_set_valign(fa_middle)

