extends Node2D

var active: bool = false
onready var hexmap = Global.hexmap
onready var target_fields = Global.TargetFields

func get_all_fields_in_range(current_hex_field, disabled_tiles, max_range):
	var fields_in_range = Array()
	for new_hex_field in hexmap.hex_types:
		var path = hexmap.find_path(
			current_hex_field, 
			new_hex_field, 
			disabled_tiles,
			max_range
			)
		if len(path) > 0: 
			fields_in_range.append(new_hex_field)
	return fields_in_range
		
func show_targets(active_character, character_positions):
	var valid_fields = []
	var current_hex_field = hexmap.position_to_hex(
		active_character.global_position
		)
	var fields_in_range = get_all_fields_in_range(
			current_hex_field, 
			active_character.disabled_tiles, 
			active_character.max_range
			)

	target_fields.overlay_hex_field(fields_in_range)
	hexmap.highlight_hex_field(
			fields_in_range, "show_targets"
		)

func execute(character, target, character_positions):
	character_positions.erase(character.get_position()) 	
	character.set_position(target)
	character_positions[target] = character	
	character.ap -=1 
