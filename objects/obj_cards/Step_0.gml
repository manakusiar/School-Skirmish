var _keybinds = global.key_binds

//Decks
var _decks = [
	cards,
	save,
	draw,
	discard
]
var _values = global.card_values 
for (var n = 0; n < array_length(_decks); ++n) {
	var _index = _decks[n]
	var _len = ds_list_size(_index)

	//Cards
	for (var i = 0; i < _len; ++i) {
	    with(_index[| i]) {
			//Variables
			var _keyboard_clicked = keyboard_global_pressed(ord(string(i+1)))
		
			var _selected = other.selected 
			var _dis = _values.dis
			var _base_x = _values.base_x
			var _x = _base_x + _dis * i
			var _y = room_height * 0.82
			var _w = sprite_get_width(sprite_index)
			var _h = sprite_get_height(sprite_index)
			var _mb_left = mouse_check_button_pressed(mb_left)
			var _mb_right = mouse_check_button_pressed(mb_right)
			var _near = global.nearest_entity
			
			var _save = _keybinds.save
			var _key_save = keyboard_check_pressed(_save)
			var _key_save_cont = keyboard_check(_save)
		
			var _spd = 0.2
			
			base_x = _x
			base_y = _y
			selected = (_selected = i)
		
			
			if n = 1 { // n is deck number (save pile)
				var _down_x = _x + 16
				var _down_y = _y + _h*1.2
				var _touching = point_in_rectangle(mouse_x, mouse_y, _down_x - _w/2, _down_y - _h/2, _down_x + _w/2, _down_y + _h/2)
				
				var _keyboard_save = _keyboard_clicked and _key_save_cont
				var _selected_save = (other.selected_save = i)
				with(other) {
					if (_touching or _keyboard_save) and not _selected_save {
						selected_save = i
						other.clicked = _touching
						
						card_move_sound(snd_slide4)
					}
					if _selected_save and (_keyboard_save or keyboard_global_released(_save) or other.clicked and not _touching) {
						selected_save = -4
						
						card_move_sound(snd_slide4)
					}
				}
				
				x_go = _down_x
				y_go = _down_y - _h * 0.6 * _selected_save
				
				var _cards_size = ds_list_size(other.cards)
				if _selected_save and mouse_check_button_pressed(mb_left) and _cards_size < other.hand_size {
					with(other) {
						card_move(save, cards, i)
						
						selected_save = -4
					}
				}
				
				
			} else if n = 0 { // n is deck number (play pile)
				var _keyboard_clicked_cards = _keyboard_clicked and not _key_save_cont
				if _selected = i {
			
					//Information
					if info = 1 {
						x_go = room_width/4
						y_go = room_height/2
						
						if _mb_left or _mb_right {
							other.selected = -4
							info = 0
						}
						
						scale_go = 2
					
					//Other selections
					} else {
						
						//Position determined by if clicked or not
						if clicked {
							x_go = _x
							y_go = _y - _h*0.25
						} else {
							_spd = 0.2
							
							var _entity_selected = arrow and _near.distance < global.entity_selection_range
							x_go = _entity_selected? _near.x : mouse_x
							y_go = _entity_selected? room_height/3 : max(mouse_y,room_height/4*3)
						}
			
						//Clickification and deselection
						if clicked and _mb_left {
							clicked = 0
						}
						if _mb_right {
							info = 1
						}
						
						
						//Released
						var _mb_left_released = mouse_check_button_released(mb_left)
						if _mb_left_released or _keyboard_clicked_cards or _key_save { // Deselection
							if click_cooldown <= 0 {
								other.selected = -4 
								
								if _mb_left_released or _key_save {
									//Checking if player can afford the card
									var _can_afford = 1
									for (var u = 0; u < array_length(cost); ++u) {
										if other.coins[u] < cost[u] {
											_can_afford = 0
										}
									}
									
									//If can fully play the card
									if mouse_y < room_height/5*4 and not _key_save {
										if _can_afford and can_play() {
											//Pay money
											for (var u = 0; u < array_length(cost); ++u) {
												other.coins[u] -= cost[u]
											}
										
											//Do card abilities
											on_play()
										
											//Move card to discard pile
											with(other) {
												card_move(cards, discard, i)
											}
										}
									} else if (mouse_y > room_height*0.95 or _key_save) and ds_list_size(other.save) < other.save_size {
										var _i = card_nearest_deck(mouse_x)
										with(other) {
											card_move(cards, save, i)
										}
									}
								}
								clicked = 0 // De-clickafy
							} else {
								clicked = 1 // Clickafy
							}
						} 
						
						//Clickation cooldown
						if click_cooldown > 0 {
							click_cooldown -= 1
						}
					}
		
				} else { // Returning back to the board
			
					//Oryginal position on the board
					x_go = base_x
					y_go = base_y
					scale_go = 1
					clicked = 0
					info = 0
			
					//Keyboard clickification
					if _keyboard_clicked_cards {
						other.selected = i
						clicked = 1
					}
				}
		
		
				//Selected by dragging
				var _touching = point_in_rectangle(mouse_x, mouse_y, x - _w/2, y - _h/2, x + _w/2, y + _h/2)
			
				if _touching and (_mb_left or _mb_right) {
					if _mb_right info = 1
					other.selected = i
					click_cooldown = 4
				}
				
				
			} else if n = 2 { // n is deck number (draw pile)
				//Go to draw pile 
				var _inst = obj_draw_pos
				if instance_exists(_inst) {
					x_go = _inst.x
					y_go = _inst.y
				}
				
				
			} else if n = 3 { // n is deck number (discard pile)
				//Go to discard pile
				var _inst = obj_discard_pos
				if instance_exists(_inst) and other.wait <= 01{
					x_go = _inst.x
					y_go = _inst.y
				}
			}
		
			x = lerp(x, x_go, _spd)
			y = lerp(y, y_go, _spd)
			
			image_xscale = lerp(image_xscale,scale_go,0.5)
			image_yscale = lerp(image_yscale,scale_go,0.5)
		
			//Angle
			image_angle += min((x - x_last)/10, 3)
			image_angle *= 0.8
		
			//Setting last position
			x_last = x
			y_last = y
		}
	}
}



var _wait_length = 20
if not wait > 0 {
	
	//Drawing
	var _cards_len = ds_list_size(cards) <= 0
	var _draw_len = ds_list_size(draw) > 0
	
	if drawing > 0 and _draw_len and not sorting and not obj_characters.new_turn.is_new {
		if draw_cooldown <= 0 {
			//if _cards_len {
			//	drawing = draw_ammount
			//}
			draw_cooldown = draw_cooldown_max
			drawing -= 1
		
			var _cards_size = ds_list_size(cards)
			if _cards_size >= hand_size {
				var _last = ds_list_size(draw) - 1
				card_move(draw, discard, _last)
			} else {
				var _last = ds_list_size(draw) - 1
				card_move(draw, cards, _last)
			}
		} else {
			draw_cooldown -= 1
		}
	} else if not _draw_len and not sorting{
		wait = _wait_length
		sorting = 1
		ds_list_shuffle(discard)
		
		var _rh = room_height *0.4
		var _discard_len = ds_list_size(discard)
		for (var i = 0; i < _discard_len; ++i) {
		    with(discard[| i]) {
				var _h = sprite_get_height(sprite_index)
				y_go -= min(_rh/_discard_len*i, _h/2*i)
				
				card_move_sound(snd_slide3)
			}
		}
	}


	//Sorting
	var _discard_len = ds_list_size(discard) > 0
	if sorting = 1 {
		if _discard_len {
			if discard_cooldown <= 0 {
				discard_cooldown = discard_cooldown_max
			
				card_move(discard, draw, 0)
			} else {
				discard_cooldown -= 1
			}
		} else {
			sorting = 0
			wait = _wait_length
		}
	}
}

if wait > 0 {
	wait -= 1
}


//Next turn
if keyboard_global_pressed(global.key_binds.next_turn) {
	repeat(ds_list_size(cards)) {
		card_move(cards,discard, 0)
	}
	
	with(obj_characters) {
		start_next_turn()
	}
	
	for (var i = 0; i < array_length(coins); ++i) {
	    if coins[i] <= 0 {
			coins[i] += i + (i = 3)
		}
	}
	
	drawing = draw_ammount
	selected = -4
}


//Selected change
if selected_last != selected {
	card_move_sound(snd_slide4)
	
	selected_last = selected
}