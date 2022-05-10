extends Node2D
class_name BaseCharacter

export var selected: bool = false 
var disabled_tiles
var hitpoints: int 
var ap: int = 5
var team: String
var hexmap
var max_range: int = 3

func play_turn():
	select_character()
	yield(get_tree().create_timer(1.0), "timeout")
	unselect_character()
	return true

func get_position():
	return hexmap.position_to_hex(global_position)

func set_position(hex_field):
	global_position = hexmap.get_center_position(hex_field)

func unselect_character():
	var selection_line = get_node("Sprite/SelectionLine")
	selection_line.visible = false
	selected = false
	
func select_character():
	var selection_line = get_node("Sprite/SelectionLine")
	selection_line.visible = true
	selected = true

func _ready():
	hexmap = Global.hexmap
	


