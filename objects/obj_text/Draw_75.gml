if global.in_conversation {
	//Variables
	var _ww = display_get_gui_width()
	var _wh = display_get_gui_height()

	var _w = _ww * 0.9
	var _h = _wh * 0.25

	var _x = _ww / 2
	var _y = _wh*0.95 - _h/2
	
	//Box
	draw_typew_box(spr_box_text, _x, _y, _w, _h)

	//Text
	draw_typew_text(_x, _y, _w, _h)
}