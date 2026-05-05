extends AnimatableBody2D

var velocity := Vector2.ZERO
var last_position := Vector2.ZERO

func _ready():
	last_position = global_position

func _physics_process(delta):
	velocity = (global_position - last_position) / delta
	last_position = global_position

func get_velocity():
	return velocity
