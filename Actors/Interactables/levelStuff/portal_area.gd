extends Area2D

@export var target_position: Vector2  # The position to teleport the player
@export var target_node_path: NodePath  # Path to the node to teleport dynamically
@onready var tilemap = $"/root/Level1/Tilemaps/grounds"  # Update to your actual node path

func _ready() -> void:
	# Check if the tilemap is valid
	if tilemap == null:
		print("Tilemap node not found!")
		return

# Triggered when a PhysicsBody2D enters this Area2D
func _on_body_entered(body: Node2D) -> void:
	print("Body entered portal")
	if tilemap != null and body.is_in_group("Player"):
		toggle_shader()
		teleport_node()

func teleport_node() -> void:
	# Get the node using the specified path
	var target_node = get_node("portaltp")
	if target_node == null:
		print("Error: Target node not found at path:", target_node_path)
		return

	# Teleport the target node to the target position
	target_node.global_position = target_position
	print("Node teleported to:", target_position)

func toggle_shader() -> void:
	# Check if the tilemap and its material are valid
	if tilemap.material == null:
		print("Tilemap material not found!")
		return

	# Get the current shader parameter value
	var shaderStatus = tilemap.material.get_shader_parameter("onoff")

	# Toggle the shader parameter
	if shaderStatus > 0.5:
		print("Shader toggled OFF")
		tilemap.material.set_shader_parameter("onoff", 0.0)
	else:
		print("Shader toggled ON")
		tilemap.material.set_shader_parameter("onoff", 1.0)
