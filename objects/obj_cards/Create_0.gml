//List
cards = ds_list_create()
discard = ds_list_create()
draw = ds_list_create()
save = ds_list_create()
selected = -4
selected_last = selected
selected_save = -4

//Card values
global.card_values = {
	dis : sprite_get_width(spr_cards_back) * 1.2,
	base_x : 960 * 0.15
}

//Hand
hand_size = 9
draw_ammount = 6

//Save
save_size = 9

//Drawing
draw_cooldown = 0
draw_cooldown_max = 4
drawing = draw_ammount

//Discard and sort
discard_cooldown = 0
discard_cooldown_max = 2
sorting = 0

//Wait
wait = 0
wchange = 0

coins = [0,0,0,0]
coins_list = [
	ds_list_create(),
	ds_list_create(),
	ds_list_create(),
	ds_list_create(),
]
coins_cooldown = 0
coins_cooldown_max = 5

//Add cards to the drawing pile
randomise()

var _bag = ds_list_create() 
repeat(15) {
	if ds_list_size(_bag) <= 0 {
		ds_list_add(_bag, health_card)
		ds_list_add(_bag, mana_card)
		ds_list_add(_bag, iron_coin_card)
		ds_list_add(_bag, silver_coin_card) 
		ds_list_add(_bag, gold_coin_card)
		ds_list_add(_bag, antidote_card)
		ds_list_add(_bag, monster_card)
		ds_list_add(_bag, monster2_card)
		ds_list_add(_bag, monster6_card)
		ds_list_add(_bag, attack_card)
	}
	ds_list_shuffle(_bag)
	ds_list_add(draw, new _bag[| 0]())
	ds_list_delete(_bag, 0)
}