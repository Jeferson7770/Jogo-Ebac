extends Sprite2D

@export var rotation_speed: float = 5.0 # Ajuste este valor para mudar a velocidade da rotação
@export var no_da_porta: NodePath
var porta_alvo: Node2D 

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
	#if body.is_in_group("shine"):
		#timer >= 2s
		#desativa porta


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("Enemy"):
		body.set_paralyzed(false)
		
		

func _ready():
	# Verifica se o caminho para o nó da porta foi definido e obtém o nó.
	if not no_da_porta.is_empty():
		porta_alvo = get_node_or_null(no_da_porta)
		

func _on_area_entered(area: Area2D):
	# Verifica se a área que entrou pertence ao grupo "chaves"
	if area.is_in_group("chaves"):
		print("Chave detectada pelo cone de visão!")
		desativar_porta()
		

func desativar_porta():
	if porta_alvo:
		print("Desativando a porta.")
		# Opção 1: Tornar a porta invisível
		porta_alvo.visible = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
