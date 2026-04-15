extends AnimatableBody2D

@export var speed := 500
@export var distance := 200
@export var direction := Vector2.UP

var start_position
var moving_forward := true
var velocity := Vector2.ZERO

func _ready():
	start_position = position

func _physics_process(delta):
	var move_dir = direction.normalized()
	var movement = move_dir * speed

	if moving_forward:
		velocity = movement
		position += movement * delta
		if position.distance_to(start_position) > distance:
			moving_forward = false
	else:
		velocity = -movement
		position -= movement * delta
		if position.distance_to(start_position) < 5:
			moving_forward = true

func get_velocity():
	return velocity
