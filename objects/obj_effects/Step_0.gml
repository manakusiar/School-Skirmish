for (var i = 0; i < ds_list_size(effects); ++i) {
    with(effects[| i]) {
		step(i)
	}
}

for (var i = 0; i < ds_list_size(destroy_effects); ++i) {
    ds_list_delete(effects, destroy_effects[| i])
    ds_list_delete(destroy_effects, i)
}