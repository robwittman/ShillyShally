extends TileMap

var rooms = [
	load("res://Scenes/Dungeons/AncientRuins/Rooms/Room1.tscn"),
	load("res://Scenes/Dungeons/AncientRuins/Rooms/Room2.tscn"),
	load("res://Scenes/Dungeons/AncientRuins/Rooms/Room3.tscn"),
]

var starting_room = load("res://Scenes/Dungeons/AncientRuins/Rooms/StartingRoom.tscn")
var map_size = Vector2(2000, 2000)
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Running generator function")
	$/root/Generator.generate(
		self,
		map_size,
		starting_room,
		rooms,
		[],
		[],
		[],
		[],
		[]
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
