extends CharacterBody2D

@export var fireball_scene: PackedScene
@export var placable_tile_scene: PackedScene
@export var magic_scene: PackedScene
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var can_place_tiles: bool = false  # Tracks if "StopTime" has been activated

func _physics_process(delta: float) -> void:
	# Check if health is zero and kill player
	if PlayerManager.current_health == 0:
		kill_player()

	# Shoot projectile (fireball) with the magic button
	if Input.is_action_just_pressed("magic"):
		shoot_fireball()

	# Cast magic with the left mouse button
	if Input.is_action_just_pressed("mb_left"):
		cast_magic()

	# Place tiles only after "StopTime" is activated
	if can_place_tiles and Input.is_action_just_pressed("mb_right"):
		place_tile()
	elif Input.is_action_just_pressed("mb_right"):
		print("You need to activate StopTime before placing tiles!")

	# Handle gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle movement and deceleration
	var direction = Input.get_axis("run_left", "run_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Flip sprite based on horizontal velocity
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false

	# Determine animations
	if is_on_floor():
		if velocity.x != 0:
			$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("idle")
	elif velocity.y > 0:
		$AnimatedSprite2D.play("fall")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("jump")

	# Move the character
	move_and_slide()

	# Activate "StopTime"
	if Input.is_action_just_pressed("TimeStop"):
		can_place_tiles = true
		print("StopTime activated! You can now place tiles.")

func shoot_fireball() -> void:
	# Instantiate the fireball scene
	if PlayerManager.crow > 0:
		PlayerManager.decrease_crow(1)
		var fireball = fireball_scene.instantiate()
		fireball.position = global_position

	# Calculate direction towards the global mouse position
		var mouse_position: Vector2 = get_global_mouse_position()
		var fireball_direction = (mouse_position - global_position).normalized()

	# Assign the direction to the fireball
		if fireball.has_method("set_direction"):
			fireball.set_direction(fireball_direction)
		else:
			fireball.direction = fireball_direction

	# Add the fireball instance to the current scene
		get_tree().current_scene.add_child(fireball)

func cast_magic() -> void:
	# Instantiate the magic object
	if PlayerManager.magica > 0:
		PlayerManager.decrease_magica(1)
		var newMagic = magic_scene.instantiate()
		print("Casting magic...")

	# Calculate direction towards the global mouse position
		var mouse_position: Vector2 = get_global_mouse_position()
		var magic_direction = (mouse_position - global_position).normalized()

	# Assign the direction to the magic instance
		newMagic.position = global_position
		if newMagic.has_method("set_direction"):
			newMagic.set_direction(magic_direction)
		else:
			newMagic.direction = magic_direction

	# Play the attack animation
		$AnimatedSprite2D.play("attack1")

	# Add the magic instance to the scene
		get_parent().add_child(newMagic)

		GameManager.playSFX(load("res://Sounds/FreeSFX/GameSFX/Magic/Retro Magic 11.wav"))

func place_tile() -> void:
	# Get mouse position and instantiate tile
	var mouse_position: Vector2 = get_global_mouse_position()
	var placable_tile_instance = placable_tile_scene.instantiate()
	placable_tile_instance.position = mouse_position
	get_tree().current_scene.add_child(placable_tile_instance)

func kill_player():
	# Handle player death logic
	$AnimatedSprite2D.flip_h = false
	$AnimatedSprite2D.play("death")
	print("Player has died!")

	# Respawn the player at the respawn point
	position = PlayerManager.respawn_point

	# Reset health
	PlayerManager.current_health = PlayerManager.max_health
	PlayerManager.increase_crow()
	# Reset the entire level
	reset_level()

func reset_level():
	
	get_tree().reload_current_scene()

func _on_death_area_body_entered(body: Node2D) -> void:
	# Trigger player death
	kill_player()

func _on_hurt_box_body_entered(body: Node2D) -> void:
	# Handle damage if collided with an enemy
	if body.is_in_group("enemy"):
		PlayerManager.decrease_health(body.damage_ammount)
		print("Player hit!")
