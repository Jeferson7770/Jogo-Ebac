extends Area2D

@onready var transition = get_parent().get_node("transition")
@export var game_over : String = "res://Cenas/game_over.tscn"

func _on_body_entered(body):
	if body.name == "player" and game_over != "":
		print("Jogador caiu na área de game over")

		# Se tiver um AnimationPlayer chamado "transition", toca a animação de fadeout
		if transition and transition.has_method("play"):
			transition.play("fade_out")

		await get_tree().create_timer(.5).timeout
		get_tree().change_scene_to_file(game_over)
	else:
		print("No Scene Loaded")
