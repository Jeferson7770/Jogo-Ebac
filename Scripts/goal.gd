extends Area2D

@onready var transition = get_parent().get_node("transition")
@export var next_level : String = "res://Cenas/fase_02.tscn"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" and next_level != "":
		# Se tiver animação de transição, toca antes
		if transition and transition.has_method("play"):
			transition.play("fade_out")

		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file(next_level)
	else:
		print("Nenhuma cena carregada.")
