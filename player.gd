extends CharacterBody2D

@export var speed = 200 # How fast the player will move (pixels/sec)
@export var jump_force = -400
var screen_size # Size of the game window.
var is_crouching = false

const GRAVITY = 800

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	$CollisionStanding.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Gravity
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += GRAVITY * delta

	# Crouching
	if Input.is_action_just_pressed("crouch") and is_on_floor():
		is_crouching = true
	if Input.is_action_just_released("crouch"):
		is_crouching = false

	if is_crouching:
		$CollisionCrouching.disabled = false
		$CollisionStanding.disabled = true
		$AnimatedSprite2D.play("crouching")
		velocity.x = 0
	else:
		$CollisionCrouching.disabled = true
		$CollisionStanding.disabled = false

		# Movement
		if Input.is_action_pressed("move_right"):
			velocity.x = speed
		elif Input.is_action_pressed("move_left"):
			velocity.x = -speed
		else:
			velocity.x = 0

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_force

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

	move_and_slide()
