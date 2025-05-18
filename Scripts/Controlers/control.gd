extends Control

@onready var creditos = $VBoxContainer/Creditos/Imagem

func _ready() -> void:
	creditos.visible = false

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fase_01.tscn") # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_creditos_pressed() -> void:
	creditos.visible = true


func _on_close_creditos_pressed() -> void:
	creditos.visible = false
