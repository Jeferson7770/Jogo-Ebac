extends CharacterBody2D

# Constantes de velocidade
const SPEED = 150.0
const JUMP_FORCE = -300.0

# Variáveis de movimento e estado
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false

@onready var remote_transform: RemoteTransform2D = $remote
@onready var anim: AnimatedSprite2D = $anim

func _physics_process(delta):
	# Aplica gravidade se não estiver no chão
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Movimentação horizontal
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED
		anim.scale.x = direction  # Inverte sprite se mudar direção
		if not is_jumping:
			anim.play("run")
	elif is_jumping:
		anim.play("jump")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("idle")

	# Move o personagem
	move_and_slide()

# Quando encosta em um inimigo ou área de game over
func _on_hurtbox_body_entered(body):
	if body.is_in_group("Enemy") or body.is_in_group("Game Over"):
		die()

# Função de morte do personagem
func die():
	anim.play("death")
	set_process(false)  # Para o processamento do personagem
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://Cenas/game_over.tscn")

# Seguir câmera via RemoteTransform2D
func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

# Quando o player entra na zona de fim de fase
func _on_fim_do_nivel_body_entered(body: Node2D) -> void:
	if body == self:
		anim.play("sleep")
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Cenas/fase_2.tscn")
