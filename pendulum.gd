extends Node2D

@export var length := 200.0
@export var max_angle := 45.0
@export var speed := 2.0

@onready var platform = $"Moving platform"

var time := 0.0
var last_position := Vector2.ZERO
var velocity := Vector2.ZERO

func _ready():
	last_position = platform.global_position
	
func get_velocity():
	return velocity

func _physics_process(delta):
	time += delta
	
	var angle = deg_to_rad(max_angle) * sin(time * speed)

	var offset = Vector2(0, length).rotated(angle)

	platform.position = offset
	
	velocity = (platform.global_position - last_position) / delta
	last_position = platform.global_position
