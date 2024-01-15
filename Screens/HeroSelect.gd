extends Control

var mainMenu = preload("res://Screens/MainMenu.tscn").instantiate()

const NUM_HEROES = 30
var current_hero = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_texture():
	var expected_texture = "res://assets/heroes/Hero_%s.png" % current_hero
	# This is probably ineffecient, we could check if the texture changes
	$Character/Sprite2D.texture = load(expected_texture)

func _on_next_button_pressed():
	if current_hero >= 30:
		current_hero = 1
	else:
		current_hero += 1
	load_texture()

func _on_previous_button_pressed():
	if current_hero <= 1:
		current_hero = 30
	else:
		current_hero -= 1
	load_texture()


func _on_select_button_pressed():
	print("Saving the following hero to config")
	print(current_hero)
	return_to_main_menu()
	pass # Replace with function body.

func return_to_main_menu():
	get_tree().root.add_child(mainMenu)
	queue_free()

func _on_back_button_pressed():
	return_to_main_menu()
