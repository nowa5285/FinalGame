extends CharacterBody2D

@export var speed: float = 75.0        # Speed of the projectile after timeout
@export var delay_time: float = 2.0      # Time before the projectile starts moving
var direction: Vector2 = Vector2.RIGHT   # Direction to shoot the projectile

var is_ready_to_shoot: bool = false      # Flag to determine when to start moving

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Only move the projectile once it is ready to shoot
	if is_ready_to_shoot:
		velocity = direction * speed
		move_and_slide()

func _on_timer_timeout() -> void:
	# Enable movement when the timer finishes
	is_ready_to_shoot = true


func _on_pd_timeout() -> void:
	queue_free()
