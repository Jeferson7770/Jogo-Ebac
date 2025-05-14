extends CharacterBody2D

# Constantes de velocidade
const SPEED = 250.0
const JUMP_FORCE = -300.0

# Pega a gravidade do projeto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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

	# Detecta movimentação horizontal (teclas esquerda e direita)
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		# Faz a velocidade horizontal ir suavemente para 0 quando não estiver pressionando nada
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Move o personagem de acordo com a velocidade calculada
	move_and_slide()
