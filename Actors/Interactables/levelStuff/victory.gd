extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Collider ready!")

func _process(delta: float) -> void:
	pass

# Triggered when a body enters the collision area
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player entered the area (body_entered).")
		get_tree().change_scene_to_file("res://Levels/VictoryRoyal.tscn")
		
		

# Triggered when an area enters the collision area
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		print("Player entered the area (area_entered).")
		GameManager.win_c = true
