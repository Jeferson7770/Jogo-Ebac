extends PointLight2D

var monsterInLight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Monster":
		monsterInLight = body # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Monster":
		monsterInLight = null # Replace with function body.
