extends Node2D
var selected_skill
var active_character

func _skill_selected(skill):
	selected_skill = get_node("%s" % skill)
	for skill in get_children():
		skill.active = false
	selected_skill.active = true

func _unhandled_input(event):
	if selected_skill:
		pass
		# selected_skill.show_targets(active_character)
	
