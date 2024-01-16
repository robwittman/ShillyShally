extends Node2D

var pauseScreen = load("res://Screens/PauseMenu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Game loaded")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc"):
			get_tree().paused = true
			add_child(pauseScreen.instantiate())
