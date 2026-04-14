extends CharacterBody2D
@export var speed = 200
@export var jump_force = -400
var screen_size
var is_crouching = false
const GRAVITY = 800

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	if Input.is_action_pressed("crouch") and is_on_floor():
		is_crouching = true
		$AnimatedSprite2D.play("crouching")
		$CollisionCrouching.disabled = false
		$CollisionStanding.disabled = true
		$CollisionJumping.disabled = true
		$CollisionWalking.disabled = true
	else:
		is_crouching = false
		$CollisionCrouching.disabled = true
		$CollisionStanding.disabled = false
		$CollisionJumping.disabled = true
		$CollisionWalking.disabled = true
	if not is_crouching:
		if Input.is_action_pressed("move_right"):
			velocity.x = speed
		elif Input.is_action_pressed("move_left"):
			velocity.x = -speed
		else:
			velocity.x = 0
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_force
		if not is_on_floor():
			$AnimatedSprite2D.play("jumping")
			$CollisionCrouching.disabled = true
			$CollisionStanding.disabled = true
			$CollisionJumping.disabled = false
			$CollisionWalking.disabled = true
		elif velocity.x != 0:
			$AnimatedSprite2D.play("walking")
			$CollisionCrouching.disabled = true
			$CollisionStanding.disabled = true
			$CollisionJumping.disabled = true
			$CollisionWalking.disabled = false
		else:
			$AnimatedSprite2D.stop()
			$CollisionCrouching.disabled = true
			$CollisionStanding.disabled = false
			$CollisionJumping.disabled = true
			$CollisionWalking.disabled = true
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0
	move_and_slide()

func pick_up_sac():
	print("pick")
	
