extends Node2D

@export var lift_distance: float = 220.0
@export var press_distance: float = 220
@export var move_time: float = 0.8

# EXTRA SPACING
@export var extra_platform_spacing: float = 800
@export var extra_pulley_spacing: float = -300
@export var vert_offset: float = -50


@onready var detector: Area2D = $HorizontalPlank/WeightDetector

@onready var horizontal_plank: Node2D = $HorizontalPlank
@onready var gate_plank: Node2D = $GatePlank

@onready var pulley_left: Node2D = $PulleyLeft
@onready var pulley_right: Node2D = $PulleyRight

@onready var plank_rope_point: Marker2D = $HorizontalPlank/PlankRopePoint
@onready var left_pulley_point: Marker2D = $PulleyLeft/LeftPulleyPoint
@onready var right_pulley_point: Marker2D = $PulleyRight/RightPulleyPoint
@onready var gate_rope_point: Marker2D = $GatePlank/GateRopePoint


var rope_left: Line2D
var rope_top: Line2D
var rope_right: Line2D


# FINAL START POSITIONS
var plank_start_position: Vector2
var gate_start_position: Vector2

var pulley_left_start: Vector2
var pulley_right_start: Vector2


var sac_count := 0
var tween: Tween


func _ready() -> void:

# ===== PLATFORM SPACING =====


	gate_plank.position +=  Vector2(extra_platform_spacing, vert_offset)



# ===== PULLEY SPACING =====
# pulleys follow platform spacing
# PLUS optional extra pulley spacing




	pulley_right.position.x += (
	extra_platform_spacing  
)
	pulley_left.position.y+= extra_pulley_spacing 
	pulley_right.position.y+= extra_pulley_spacing
	# ===== SAVE FINAL MODIFIED POSITIONS =====

	plank_start_position = horizontal_plank.position
	gate_start_position = gate_plank.position

	pulley_left_start = pulley_left.position
	pulley_right_start = pulley_right.position


	# ===== DETECTOR SETUP =====

	detector.monitoring = true
	detector.monitorable = true

	detector.body_entered.connect(_on_detector_entered)
	detector.body_exited.connect(_on_detector_exited)
	detector.area_entered.connect(_on_detector_entered)
	detector.area_exited.connect(_on_detector_exited)


	# ===== CREATE ROPES =====

	rope_left = _create_rope()
	rope_top = _create_rope()
	rope_right = _create_rope()

	_update_ropes()


func _process(_delta: float) -> void:
	_update_ropes()


func _create_rope() -> Line2D:
	var rope := Line2D.new()
	add_child(rope)

	rope.set_as_top_level(true)
	rope.global_position = Vector2.ZERO
	rope.width = 5
	rope.default_color = Color(0.35, 0.16, 0.03)
	rope.antialiased = true
	rope.z_index = 20

	return rope


func _on_detector_entered(node: Node) -> void:
	print("entered detector: ", node.name)

	if _is_sac(node):
		print("sac detected")
		sac_count += 1
		_activate_mechanism()


func _on_detector_exited(node: Node) -> void:
	print("exited detector: ", node.name)

	if _is_sac(node):
		sac_count = max(0, sac_count - 1)

		if sac_count == 0:
			_reset_mechanism()


func _is_sac(node: Node) -> bool:

	if node.is_in_group("sac"):
		return true

	if node.get_parent() and node.get_parent().is_in_group("sac"):
		return true

	if node.owner and node.owner.is_in_group("sac"):
		return true

	return false


func _activate_mechanism() -> void:

	_move_parts(
		plank_start_position + Vector2(0, press_distance),
		gate_start_position + Vector2(0, -lift_distance+vert_offset)
	)


func _reset_mechanism() -> void:

	_move_parts(
		plank_start_position,
		gate_start_position+ Vector2(0, vert_offset)
	)


func _move_parts(plank_target: Vector2, gate_target: Vector2) -> void:

	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_parallel(true)


	# ONLY MOVE VERTICALLY
	tween.tween_property(
		horizontal_plank,
		"position:y",
		plank_target.y,
		move_time
	)

	tween.tween_property(
		gate_plank,
		"position:y",
		gate_target.y,
		move_time
	)


func _update_ropes() -> void:

	if rope_left == null or rope_top == null or rope_right == null:
		return


	rope_left.points = [
		plank_rope_point.global_position,
		left_pulley_point.global_position
	]

	rope_top.points = [
		left_pulley_point.global_position,
		right_pulley_point.global_position
	]

	rope_right.points = [
		right_pulley_point.global_position,
		gate_rope_point.global_position
	]
