extends Node2D

func connect_controll_signals():
	var controls = get_node("Control").get_children()
	var combatents = get_node("TurnQueue/Combatants")
	for control in controls:
		control.connect("skill_selected", combatents, "_skill_selected")

	
func _ready():
	connect_controll_signals()
