extends CharacterBody2D

@export var speed = 400 # How fast the player will move (pixels/sec)
@export var jump_force = -550
var screen_size # Size of the game window.
var is_crouching = false
var platform_velocity := Vector2.ZERO
var has_sac = false
var sac_scene = preload("res://sac.tscn")

const GRAVITY = 1200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	$CollisionStanding.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var current_speed = float(speed) / 2.0 if has_sac else float(speed)
	var current_jump = jump_force * 0.9 if has_sac else float(jump_force)
	var current_gravity = GRAVITY * 1.5 if has_sac else float(GRAVITY)
	# Gravity
	if is_on_floor():
		velocity.y = 0
		var collision = get_last_slide_collision()
		if collision:
			var collider = collision.get_collider()
			if collider.has_method("get_velocity"):
				platform_velocity = collider.get_velocity()
			else:
				platform_velocity = Vector2.ZERO
	else:
		velocity.y += current_gravity * _delta
	
	# Crouching
	if Input.is_action_just_pressed("crouch") and is_on_floor():
		is_crouching = true
	if Input.is_action_just_released("crouch"):
		is_crouching = false

	if is_crouching:
		$CollisionCrouching.disabled = false
		$CollisionStanding.disabled = true
		if Input.is_action_pressed("move_right"):
			velocity.x = current_speed / 2.0  # slower while crouching
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("crouching_walk")
		elif Input.is_action_pressed("move_left"):
			velocity.x = -current_speed / 2.0
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("crouching_walk")
		else:
			velocity.x = 0
			$AnimatedSprite2D.play("crouching")
	else:
		# Movement
		if Input.is_action_pressed("move_right"):
			velocity.x = current_speed
		elif Input.is_action_pressed("move_left"):
			velocity.x = -current_speed
		else:
			velocity.x = 0
		if not is_on_floor():
			velocity.x += platform_velocity.x


		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = current_jump
		# Flip sprite
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0
		
		# Animations
		if not is_on_floor():
			$AnimatedSprite2D.play("jumping")
		elif velocity.x != 0:
			$AnimatedSprite2D.play("walking")
		else:
			$AnimatedSprite2D.play("standing")
	print(platform_velocity)
	
	if position.y > 1000:
		set_physics_process(false)  # stop the player from moving
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
		
	move_and_slide()
	
func pick_up_sac():
	print("pick")
	has_sac = true

func _process(delta):
	if has_sac and Input.is_action_just_pressed("ui_accept"):
		drop_sac()
		
	if Input.is_action_just_pressed("restart"):
		set_physics_process(false)
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
		
func drop_sac():
	has_sac = false
	var sac = sac_scene.instantiate()
	sac.position = position
	get_parent().add_child(sac)
	print("drop")
