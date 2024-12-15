extends CharacterBody2D

@export var speed: float = 50.0
@export var damage_ammount : int = 1
@export var health : int = 2
var player: Node2D

func _ready() -> void:
	# Get the player node from the current scene
	player = get_tree().current_scene.get_node("Player")
func _process(delta: float) -> void:
	if health <= 0:
		$AnimatedSprite2D.play("death")
		
		queue_free()

func _physics_process(delta: float) -> void:
	
	# If the player is found, chase the player
	if player != null:
		chase_player(delta)
	

func chase_player(delta: float) -> void:
	# Calculate the direction towards the player
	var direction: Vector2 = (player.global_position - global_position).normalized()

	# Set the velocity to move towards the player
	velocity = direction * speed

	# Flip the sprite based on the direction of movement
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

	# Move the flying eye using move_and_slide()
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectiles"):
		health -=1
