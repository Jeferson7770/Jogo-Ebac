extends Node2D

const WAIT_DURATION := 1.0

@onready var platform: AnimatableBody2D = $platform
@export var move_speed: float = 3.0
@export var distance: float = 192.0
@export var move_horizontal: bool = true

var follow: Vector2 = Vector2.ZERO
var platform_center: float = 16.0

func _ready() -> void:
	move_platform()

func _physics_process(_delta: float) -> void:
	platform.position = platform.position.lerp(follow, 0.5)

func move_platform() -> void:
	var move_direction: Vector2 = Vector2.RIGHT * distance if move_horizontal else Vector2.UP * distance
	var duration: float = move_direction.length() / (move_speed * platform_center)

	var tween = create_tween()
	tween.set_loops()  # faz o tween repetir infinitamente
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN_OUT)

	# Vai para o ponto alvo
	tween.tween_property(self, "follow", move_direction, duration).set_delay(WAIT_DURATION)

	# Volta para a origem
	tween.tween_property(self, "follow", Vector2.ZERO, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).set_delay(WAIT_DURATION)
