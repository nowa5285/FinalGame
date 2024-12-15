extends AnimatedSprite2D

# Variable to track if the chest is open
var is_open = false

func _ready() -> void:
	# Ensure the chest starts in the "closed" state
	pass

func open_chest() -> void:
	# Check if the chest is already open
	if is_open:
		return
	
	# Play the "open" animation and set the chest as open
	play("open")
	is_open = true

func _on_Area2D_body_entered(body: Node) -> void:
	# Check if the player is nearby and enable interaction
	if body.is_in_group("player") and not is_open:
		print("Player nearby. Press 'interact' to open the chest.")
		set_process_input(true)

func _on_Area2D_body_exited(body: Node) -> void:
	# Disable interaction when the player leaves the area
	if body.is_in_group("player"):
		set_process_input(false)

func _input(event: InputEvent) -> void:
	# Check if the "interact" key is pressed
	if event.is_action_pressed("interact"):
		open_chest()
