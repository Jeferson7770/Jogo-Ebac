extends Control

@onready var sprite: Sprite2D = $VBoxContainer/Creditos/creditos

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/fase_prototipo.tscn") # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()



func _on_creditos_pressed() -> void:
	sprite.visible = true


func _on_close_pressed() -> void:
	sprite.visible = false
