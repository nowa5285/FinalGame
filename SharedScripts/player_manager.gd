extends Node

@onready var health_bar = $CanvasLayer/ProgressBar
signal interact_pressed
@export var magica : int = 5 
@export var crow: int = 2
@onready var crow_n: Label = $CanvasLayer/Label
@onready var magica_n: Label = $CanvasLayer/Label2
@export var max_health: int = 3
var current_health: int
@export var respawn_point: Vector2 = Vector2.ZERO  # Default respawn position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health
	health_bar.value = current_health
	
	update_label() 

func decrease_health(health_amount: int) -> void:
	current_health -= health_amount
	if current_health < 0:
		current_health = 0
	health_bar.value = current_health

func increase_health(health_amount: int) -> void:
	current_health += health_amount
	if current_health > max_health:
		current_health = max_health
	health_bar.value = current_health

 

# Function to update the label text
func update_label():
	crow_n.text = "" + str(crow)
	magica_n.text = "" + str(magica)
# Example function to increase the score
func decrease_crow(points: int) -> void:
	crow -= points
	update_label()
	
func increase_crow():
	crow == 2
	update_label()
	
func decrease_magica(points: int) -> void:
	magica -= 1
	update_label()
	
func increase_magica(points: int) -> void:
	magica += 1
	update_label()
