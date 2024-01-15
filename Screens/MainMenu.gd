extends Control

var HeroSelectMenu = load("res://Screens/HeroSelect.tscn")
var Settings = load("res://Screens/Settings.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	#var settingsMenu = SettingsMenu.instantiate()
	#get_tree().root.add_child(settingsMenu)
	#queue_free()
	pass


func _on_hero_select_pressed():
	var heroMenu = HeroSelectMenu.instantiate()
	get_tree().root.add_child(heroMenu)
	queue_free()


func _on_host_pressed():
	# TODO: This should instead send to the Lobby scene
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
