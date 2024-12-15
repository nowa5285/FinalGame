extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -400.0
var player : Node2D
var chase = false
@export var health : int = 5
@export var damage_ammount : int = 3.4

func _ready() -> void:
	player = get_tree().current_scene.get_node("Player")
	
	
func _physics_process(delta: float) -> void:
	if health <= 0:
		queue_free()
	# Apply gravity
	velocity += get_gravity() * delta

	# Check if chasing
	if chase == true:
		$AnimatedSprite2D.play("run")
		
		var direction = (player.position - self.position).normalized()

		# Move towards the player
		if direction.x > 0:
			velocity.x = direction.x * SPEED
			$AnimatedSprite2D.flip_h = false
		else:
			velocity.x = direction.x * SPEED
			$AnimatedSprite2D.flip_h = true
	else:
		# Play idle animation when not chasing
		$AnimatedSprite2D.play("idle")

	# Move the enemy
	move_and_slide()

func _on_player_detection_body_entered(body: Node2D) -> void:
	# Start chasing when the player enters the detection area
	if body.name == "Player":
		chase = true





func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectiles"):
		health -= 1
