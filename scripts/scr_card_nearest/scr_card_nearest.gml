function card_nearest_deck(_x) {
	var _values = global.card_values
	return round((_x - _values.base_x) / _values.dis)
}