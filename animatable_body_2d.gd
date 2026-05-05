extends AnimatableBody2D

@export var swing_angle := 45.0
@export var swing_speed := 2.0

var time := 0.0
var velocity := Vector2.ZERO
var last_position := Vector2.ZERO
@onready var cord = $"../Line2D"

func _ready():
	last_position = global_position

func _physics_process(delta):
	time += delta * swing_speed
	
	var pivot = get_parent().global_position
	var arm_length = global_position.distance_to(pivot)
	var angle = deg_to_rad(swing_angle) * sin(time)
	
	var new_position = pivot + Vector2(
		sin(angle) * arm_length,
		cos(angle) * arm_length
	)
	
	velocity = (new_position - last_position) / delta
	last_position = global_position
	global_position = new_position
	rotation = angle
	
	cord.clear_points()
	cord.add_point(Vector2.ZERO)
	cord.add_point(to_local(global_position))

func get_velocity():
	return velocity
