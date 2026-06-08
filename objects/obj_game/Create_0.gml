var _amo = 2
var _w = display_get_gui_width() / _amo
var _h = display_get_gui_height() / _amo
surface_resize(application_surface,_w,_h)

var _upscale = 2
window_set_size(_w*_upscale,_h*_upscale)
window_center()

draw_set_font(fnt_pixel)
draw_set_valign(fa_middle)
draw_set_halign(fa_center)

window_set_fullscreen(true)

randomise()


global.key_binds = {
	save : ord("V"),
	next_turn : ord("R")
}