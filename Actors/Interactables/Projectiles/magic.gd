extends Area2D

@export var speed: float = 250
var velocity: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.RIGHT  # Default direction (shoots rightward)

func _process(delta: float) -> void:
	# Calculate velocity based on direction
	velocity = direction * speed * delta

	# Update particle gravity (optional)
	if $Mp/CPUParticles2D:
		$Mp/CPUParticles2D.gravity = Vector2(-3000 * direction.x, $Mp/CPUParticles2D.gravity.y)

	# Move the object
	position += velocity

func _on_timer_timeout() -> void:
	# Free the node when the timer times out
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		queue_free()

func set_direction(new_direction: Vector2) -> void:
	# Set the direction for the projectile
	direction = new_direction.normalized()


func _on_recharge_timeout() -> void:
	PlayerManager.increase_magica(2)
	PlayerManager.update_label()
