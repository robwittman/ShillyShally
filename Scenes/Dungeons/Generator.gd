extends Node

var common_treasure: Array

var miniboss_room_chance := 0.05
var puzzle_room_chance := 0.20
var treasure_spawn_chance := 0.00

func generate(
	scene: TileMap,
	map_size: Vector2,
	starting_room_resource: Resource,
	base_rooms: Array,
	boss_rooms: Array,
	miniboss_rooms: Array,
	puzzle_rooms: Array,
	enemy_spawns: Array,
	treasure_spawns: Array,
):
	print("Generating map")
	var x_size = map_size[0]
	var y_size = map_size[1]
	
	# Place the starting room. 
	# It must be placed in the center of the bottom row first
	var starting_room_location = Vector2(x_size / 2, y_size)
	print("Placing starting room at:")
	print(starting_room_location)
	
	var starting_room = starting_room_resource.instantiate()
	place_room(scene, starting_room, starting_room_location)

	# Place a bunch of random non-overlapping rooms.
		# Chance for miniboss room
	# Fill in the remaining solid regions with mazes.
	# Connect each of the mazes and rooms to their neighbors, with a chance to add some extra connections.
	# Remove all of the dead ends.
	
func place_room(scene: Node, room: Node, position: Vector2):
	room.position = position
	scene.add_child(room)
