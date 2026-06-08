text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam mi eros, accumsan at ligula quis, porta rutrum turpis. Cras vitae porta nunc. Nulla facilisi. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris sagittis, mi ornare rhoncus ullamcorper, purus sapien lobortis erat, at ornare lorem libero quis tortor. Suspendisse ullamcorper ligula lectus, quis bibendum mi dapibus eget. Morbi commodo enim eget nulla egestas aliquam."

global.in_conversation = 0

#region TYPE WRITER

//Variables and functions
typew = {
	cooldown : 0,
	cooldown_max : 2,
	letters : ds_list_create(),
	
	letter : function(_letter) constructor {
		letter = _letter
		
		extra_x = 0
		extra_y = 0
	
		image_blend = c_white
		image_xscale = 1
		image_yscale = 1
		image_alpha = 1
	},
	
	fill_letters : function() {
		var _text = obj_text.text
		var _len = string_length(_text)
		for (var i = ds_list_size(letters) + 1; i < _len; ++i) {
		    var _letter = string_char_at(_text,i)
		
			ds_list_add(letters, new letter(_letter))
		}
	}
}

//Draw text with formating
function draw_typew_text(base_x, base_y, base_width, base_height) {
	draw_set_valign(fa_top)
	draw_set_halign(fa_left)
	draw_set_font(fnt_big_pixel)

	//Get typewritten text
	var _text = ""
	with(typew) {
		var _len = ds_list_size(letters)
		for (var i = 0; i < _len; ++i) {
		    with(letters[| i]) {
				_text += letter
		
				extra_x *= 0.7
				extra_y *= 0.7
		
				image_alpha = lerp(image_alpha, 1, 0.3)
			}
		}
	}

	//Variables
	
	var _scale = 0.75
	var _h_margin = 6
	var _v_margin = 2
	var _max_w = base_width - _h_margin*2
	var _sep = string_height(" ") * _scale
	
	var _text_width = string_width_ext(text,_sep,_max_w) * _scale
	var _text_height = string_height_ext(text,_sep,_max_w) * _scale

	var _x = base_x - min(_text_width, base_width/2)
	var _y = base_y - min(_text_height, base_height/2)
	
	var _tx = _x + _h_margin
	var _ty = _y + _v_margin
	
	var _full_text_width = 0

	var _text_tokenised = string_split(obj_text.text," ")
	var _current_letter = 0

	//Draw text
	with(obj_text.typew) {
		var _tokens = string_split(_text," ") // Tokenise
		for (var n = 0; n < array_length(_tokens); ++n) {
		
			//Text formating
			if _full_text_width + string_width(_text_tokenised[n] + " ") * _scale > _max_w {
				_tx = _x + _h_margin
				_ty += _sep
				_full_text_width = 0
			}
		
			//Draw Letters
			for (var i = 1; i <= string_length(_tokens[n]); ++i) {
				var _letter = string_char_at(_tokens[n], i)
			    var _letter_w = string_width(_letter) * _scale
	
			
	
				with(letters[| _current_letter]) {
					draw_set_alpha(image_alpha)
					draw_text_transformed(_tx+extra_x,_ty+extra_y,_letter,_scale,_scale,0)
					draw_set_alpha(1)
				}
				_current_letter += 1
	
				_tx += _letter_w
			}
		
			//Add to values
			_full_text_width += string_width(_tokens[n] + " ") * _scale
			_tx += string_width(" ") * _scale
			_current_letter += 1
		}
	}

	draw_set_valign(fa_middle)
	draw_set_halign(fa_center)
	draw_set_font(fnt_pixel)
}

//Draw box of text
function draw_typew_box(_sprite_index,base_x, base_y, base_width, base_height) {
	var _xscale = base_width / sprite_get_width(_sprite_index)
	var _yscale = base_height / sprite_get_height(_sprite_index)

	draw_sprite_ext(_sprite_index,0,base_x,base_y,_xscale,_yscale,0,c_white,1)
}
	
#endregion