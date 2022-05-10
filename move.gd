extends Button
signal skill_selected(skill)

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("skill_selected", "Move")
