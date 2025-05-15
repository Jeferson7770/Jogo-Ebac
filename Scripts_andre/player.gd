extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var motion = Vector2()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$AnimatedSprite2D.play("default")
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$AnimatedSprite2D.play("default")
		$AnimatedSprite2D.flip_h = true
	else:
		motion.x = 0
		$AnimatedSprite2D.play("default")
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
