extends PointLight2D

var monsterInLight

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	var space_state = get_world_2d().direct_space_state
	#if monsterInLight:
		#var result = space_state.intersect_ray(position, monsterInLight.position, [self])
		#if result && result.collider.name == "Monster":
			#print("Hit monster")


func _on_area_2d_body_entered(body: Node2D):
	if body.name == "Monster":
		monsterInLight = body #


func _on_area_2d_body_exited(body: Node2D):
	if body.name == "Monster":
		monsterInLight = null #
