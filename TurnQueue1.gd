extends Node2D
class_name turn_queue

# onready var tilemap = get_node("/root/Map/TileMap2") 
var positions: Dictionary
var inv_positions: Dictionary
var active_character
var continue_to_next_turn: bool = true
var all_characters
var actve_character_id 
var continue_fight
var k 
#func get_all_characters():
#	var teams = get_parent().get_node("Characters").get_children()
#	var all_characters = [] 
#	for i in range(len(teams)):
#		all_characters.append(
#			teams[i].get_children()
#		)
#	return all_characters

# Called in battle container
func initalize_turn_queue():
	actve_character_id = 0
	active_character = all_characters[actve_character_id]
	continue_fight = true
	
func check_battle_state():
	get_children()

func play_turn():
	yield(active_character.play_turn(), "completed")
	if continue_fight:
		if actve_character_id >= len(all_characters)-1:
			actve_character_id = 0
		else:
			actve_character_id += 1
		active_character = all_characters[actve_character_id]
		play_turn()


	
func _ready():
	pass
	# initialize_teams()
#	for chararcter in get_children():
#		positions[chararcter.get_name()] = \
#			tilemap.position_to_hex_field(chararcter.global_position)
#
#		inv_positions[tilemap.position_to_hex_field(chararcter.global_position)] =\
#		 chararcter
	# play_turn()	
