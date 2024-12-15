extends Node

var keys= 0 
var dj_scroll = 0
var tp_scroll = 0


@export var score: int = 0
@onready var label: Label = $CanvasLayer/vic # Automatically assign the label node
@export var win_c: float = false
var offset: Vector2 = Vector2(50, 50)
# Called when the node enters the scene tree for the first time

func _ready() -> void:
	pass  # Update the label text with the initial score
	
func _win():
	update_label()

# Function to update the label text
func update_label():
	label.text = "You win!" 
	get_tree().change_scene_to_file(".")
	
# Example function to increase the score
func increase_score(points: int) -> void:
	score += points
	update_label()


	
 

func playSFX(stream):
	$SFX.stream = stream
	$SFX.play()
	
