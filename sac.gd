extends CharacterBody2D

var player_nearby = false
var player_ref = null
const GRAVITY = 800
const PUSH_SPEED = 100
const FRICTION = 400

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	# Pousser le sac
	if player_nearby and player_ref:
		# Direction du joueur vers le sac
		var direction = sign(position.x - player_ref.position.x)
		
		# Si le joueur appuie sur la touche dans la direction du sac
		if direction > 0 and Input.is_action_pressed("move_right"):
			velocity.x = PUSH_SPEED
		elif direction < 0 and Input.is_action_pressed("move_left"):
			velocity.x = -PUSH_SPEED
		else:
			# Friction quand on ne pousse pas
			velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	else:
		# Friction quand le joueur n'est pas là
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
	move_and_slide()

func _on_body_entered(body):
	if body is CharacterBody2D and body.name == "Player":
		player_nearby = true
		player_ref = body

func _on_body_exited(body):
	if body is CharacterBody2D and body.name == "Player":
		player_nearby = false
		player_ref = null

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("pick_drop"):
		player_ref.pick_up_sac()
		queue_free()
