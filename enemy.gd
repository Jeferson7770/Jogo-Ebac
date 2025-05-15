extends CharacterBody2D

# Variáveis do inimigo
@export var speed: float = 50
@export var health: int = 100
@export var stop_distance: float = 5
@onready var wall_detector :=$Wall_detector as RayCast2D
@onready var player = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var jump_force: float = -300.0

func _ready():
	player = get_parent().get_node("player")

func _physics_process(delta):
	
	
	# Aplica gravidade se não estiver no chão
	if not is_on_floor():
		velocity.y += gravity * delta
	

	# Persegue o player
	if player:
		var distance = global_position.distance_to(player.global_position)
		
		if distance > stop_distance:
			var direction = (player.global_position - global_position).normalized()
			velocity.x = direction.x * speed
			flip(direction)
		else:
			velocity.x = 0
	
	move_and_slide()

func flip(direction: Vector2):
	if direction.x > 0:
		$AnimatedSprite2D.scale.x = -1  # olha pra direita
	elif direction.x < 0:
		$AnimatedSprite2D.scale.x = 1  # olha pra esquerda

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()
	

	
		
		
