// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function effect_new(_effect, _team, _number){
	with(obj_effects) {
		ds_list_add(effects,new _effect(_team, _number))
	}
}