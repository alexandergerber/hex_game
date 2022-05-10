extends Node2D
var character = load("res://Characters/Troll.tscn")
onready var hexmap = Global.hexmap
#var positions: Dictionary
#var inv_positions: Dictionary
var active_character
var combatants 
var actve_character_id 
var continue_fight: bool = true

func spawn_characters():
	var active_characters = get_node("Combatants")
	var troll_scene = load("res://Characters/Troll.tscn")
	for i in range(-2, 3, 1):
		var troll1 = troll_scene.instance()
		troll1.name = "troll" + str(i)
		troll1.team =  "team 1"
		troll1.position = hexmap.get_center_position(
			Vector3(-3, 2 + i, 1 + i)
		)
		active_characters.add_child(troll1)

func initalize_turn_queue():
	var combatants = get_node("Combatants")
	combatants.skills = $Skills
	combatants.selected_skill = $Skills.get_node("Move")
	continue_fight = true
	actve_character_id = 0
	combatants.active_character = combatants.get_children()[actve_character_id]

func play_turn():
	$Combatants.init_new_turn()
	yield(get_node("Combatants"), "turn_over")
	$Combatants.active_character.unselect_character()
	if continue_fight:
		if actve_character_id >= len($Combatants.get_children())-1:
			actve_character_id = 0
		else:
			actve_character_id += 1
			
		$Combatants.active_character = $Combatants\
			.get_children()[actve_character_id]
			
		play_turn()


func _ready():
	spawn_characters()
	$Combatants.update_character_positions()
	# connect_skills_to_characters()
	initalize_turn_queue()
	play_turn()




