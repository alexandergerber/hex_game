extends Node2D

var move_direction = Vector2(0, 0)
export var cam_speed = 5

func _process(delta):
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	move_direction = move_direction.normalized() * cam_speed
	position += move_direction

func _ready():
	var cam = get_node("Camera2D")
	cam.activate()
