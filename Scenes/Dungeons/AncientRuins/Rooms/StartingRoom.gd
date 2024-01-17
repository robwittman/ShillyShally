extends TileMap

var door_open = false

var doorCellLayer = 0
var doorCellLocation = Vector2(5, 0)

var animatedDoorTileLayer = 0
var animatedDoorTileSource = 4
var animatedDoorTile = Vector2(5,4)

var openDoorTileLayer = 0
var openDoorTileSource = 6
var openDoorTile = Vector2(41, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") and not door_open:
		open_main_door()

func open_main_door():
	# TODO: For whatever reason, the animation is always running 
	# in the background. So when we place in the tile, it doesn't 
	# animate from the start. Instead, it picks up wherever it is 
	# in the current animation loop?
	set_cell(
		doorCellLayer,
		doorCellLocation,
		animatedDoorTileSource,
		animatedDoorTile
	)
	await get_tree().create_timer(0.7).timeout
	set_cell(
		doorCellLayer,
		doorCellLocation,
		openDoorTileSource,
		openDoorTile
	)
	door_open = true
