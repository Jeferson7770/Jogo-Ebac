extends CharacterBody2D

# Variáveis do inimigo
@export var speed: float = 165
@export var health: int = 100
@export var stop_distance: float = 1
@onready var player = null
@onready var wall_detector := $Wall_detector as RayCast2D

# Nova variável pra controle de paralisia
var is_paralyzed: bool = true

func _ready():
	player = get_parent().get_node("player")

func _physics_process(delta):
	# Se estiver paralisado, não faz nada
	if is_paralyzed:
		velocity = Vector2.ZERO
	else:
		# Se tiver player na cena
		if player:
			var distance = global_position.distance_to(player.global_position)

			# Se estiver longe, voa na direção do player
			if distance > stop_distance:
				var direction = (player.global_position - global_position).normalized()
				velocity = direction * speed  # Movimento completo em X e Y
				flip(direction)
			else:
				velocity = Vector2.ZERO

	# Move o inimigo
	move_and_slide()

func flip(direction: Vector2):
	# Mantém virado para a direção horizontal de movimento
	if direction.x > 0:
		$AnimatedSprite2D.scale.x = 1  # olha pra direita
	elif direction.x < 0:
		$AnimatedSprite2D.scale.x = -1   # olha pra esquerda

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()

# Novo método para definir paralisia
func set_paralyzed(state: bool):
	is_paralyzed = state

	

	
		
		


func _on_limite_perseguição_body_entered(body: Node2D) -> void:
	velocity.x = 0
