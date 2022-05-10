extends Node2D
var skills
var selected_skill
var character_positions: Dictionary
var active_character 

onready var hexmap = Global.hexmap

signal turn_over

func init_new_turn():
	active_character.select_character()
	selected_skill.show_targets(active_character, character_positions)
	
func update_character_positions():
	for character in get_children():
		var hex = character.get_position()
		character_positions[hex] = character

func _skill_selected(skill):
	selected_skill = skills.get_node("%s" % skill)
	selected_skill.show_targets(active_character, character_positions)

func _unhandled_input(event):
	print(selected_skill.get_name())
#	if event.get_action_strength("left_click"):
#		if selected_skill:
#			selected_skill.execute(
#				active_character, 
#				hexmap.position_to_hex(get_global_mouse_position()),
#				character_positions
#			)
#			if active_character.ap < 1:
#				emit_signal("turn_over")
#			else:
#				selected_skill.show_targets(active_character, character_positions)
#
#	elif event == InputEventMouseMotion:
#		selected_skill.highlight_path()
#
