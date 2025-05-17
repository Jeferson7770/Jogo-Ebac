extends Sprite2D

@export var rotation_speed: float = 5.0 # Ajuste este valor para mudar a velocidade da rotação

# Chamado a cada frame. 'delta' é o tempo decorrido desde o frame anterior.
func _process(delta):
	# Obtém a posição global do mouse.
	var mouse_position = get_global_mouse_position()
	
	var target_angle = (mouse_position - global_position).angle()

	# Interpola suavemente entre o ângulo atual e o ângulo alvo
	rotation = lerp_angle(rotation, target_angle, delta * rotation_speed)


	# Calcula o ângulo entre a posição do objeto e a posição do mouse.
	# A função angle() de um vetor retorna o ângulo em radianos.
	# (mouse_position - global_position) nos dá o vetor que vai do objeto para o mouse.
	var angle = (mouse_position - global_position).angle()

	# Define a rotação do objeto para o ângulo calculado.
	# A propriedade rotation em Node2D espera um ângulo em radianos.
	rotation = angle


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("Enemy"):
		body.set_paralyzed(true)


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("Enemy"):
		body.set_paralyzed(false)
