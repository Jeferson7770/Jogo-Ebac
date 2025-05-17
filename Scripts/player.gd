extends CharacterBody2D
# Constantes de velocidade
const SPEED = 150.0
const JUMP_FORCE = -310.0
var motion = Vector2()
# Pega a gravidade do projeto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
@onready var remote_transform := $remote as RemoteTransform2D
func _physics_process(delta):
	# Aplica gravidade se não estiver no chão
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Se estiver no chão e a velocidade vertical for maior que 0, zera para evitar acúmulo
		velocity.y = 0

	# Verifica se pressionou o botão de pulo (ui_accept) e está no chão
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Detecta movimentação horizontal (teclas esquerda e direita)
	var direction = Input.get_axis("ui_left", "ui_right")
	
	

	if direction != 0:
		velocity.x = direction * SPEED
		$anim.scale.x = direction
		if !is_jumping:
			$anim.play("run")
	elif is_jumping:
		$anim.play("jump")
	else:
		# Faz a velocidade horizontal ir suavemente para 0 quando não estiver pressionando nada
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$anim.play("idle")

	# Move o personagem de acordo com a velocidade calculada
	move_and_slide()


func _on_hurtbox_body_entered(body):
	if body.is_in_group("Enemy"):
		get_tree().change_scene_to_file("res://Cenas/game_over.tscn") 


# Função de morte do personagem
func die():
	#anim.play("death")
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
		#anim.play("sleep")
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Cenas/fase_2.tscn")
