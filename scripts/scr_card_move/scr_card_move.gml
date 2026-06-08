function card_move_sound(_sound, _gain = 1, _offset = 0, _pitch = 1, _pitch_diff = 0.05) {
	audio_play_sound(_sound, 0, false, 1, 0, 1 + random_range(-_pitch_diff,_pitch_diff))
}

function card_move(from, to, number){
	ds_list_add(to,from[| number])
	ds_list_delete(from,number)
	
	card_move_sound(snd_slide3)
}