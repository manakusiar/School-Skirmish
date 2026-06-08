
if global.in_conversation {
	var _text = text
	with(typew) {
		var _len = ds_list_size(letters) 
	
		//Insta-fill
		var _space = keyboard_check(vk_space)
		var _space_pressed = keyboard_check_pressed(vk_space)
		if _space_pressed and keyboard_check(vk_shift) fill_letters()
	
		var _complete = string_length(_text) < _len
	
		if cooldown <= 0 {
			if not _complete {
				cooldown = cooldown_max - (cooldown_max-1) * _space // Cooldown
		
				//Add letter
				repeat(1 + 2 * _space) {
					_len += 1
					var _letter = string_char_at(_text,_len)
					
					ds_list_add(letters, new letter(_letter))
					with(letters[| _len-1]) {
						extra_x += 8
						image_alpha = 0
					}
		
					//Sound
					if _letter != " " and _space = false or _len % 4 = 1 {
						audio_play_sound(snd_select,0,0)
					}
				}
			} else {
				if _space_pressed {
					global.in_conversation = 0
				}
			}
		} else {
			cooldown -= 1
		}
	}
} else {
	with(typew) {
		if ds_list_size(letters) > 0 ds_list_clear(letters)
		
	}
}

if keyboard_check_pressed(ord("C")) {
	global.in_conversation = 1
}