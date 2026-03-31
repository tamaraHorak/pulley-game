extends CharacterBody2D


@export var speed := 100
@export var distance := 200
@export var direction := Vector2.RIGHT

var start_position
var moving_forward := true

func _ready():
	start_position = global_position

func _physics_process(delta):
	var movement = direction.normalized() * speed

	if moving_forward:
		velocity = movement
		if global_position.distance_to(start_position) > distance:
			moving_forward = true
	else:
		velocity = -movement
		if global_position.distance_to(start_position) < 5:
			moving_forward = true

	move_and_slide()
