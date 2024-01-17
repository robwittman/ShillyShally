extends Node

# List of common treasure resources
var common_treasure: Array

# RNG chances for various spawns
var miniboss_room_chance := 0.05
var puzzle_room_chance := 0.20
var treasure_spawn_chance := 0.00

# Force at least 3 tiles between each room
var room_padding := 3

var max_rooms := 10
var current_rooms := 0

func generate(
	scene: TileMap,
	# character: CharacterBody2D,
	map_size: Vector2,
	starting_room_resource: Resource,
	base_rooms: Array,
	boss_rooms: Array,
	miniboss_rooms: Array,
	puzzle_rooms: Array,
	enemy_spawns: Array,
	treasure_spawns: Array,
):
	var x_size = map_size[0]
	var y_size = map_size[1]
	
	# Place the starting room. 
	# It must be placed in the center of the bottom row first
	var starting_room_location = Vector2(x_size / 2, y_size)	
	var starting_room = starting_room_resource.instantiate()
	place_room(scene, starting_room, starting_room_location)
	
	# Place the boss room in one of the far corners of the tilemap 
	# place_boss_room()
	
	# Now that we have the starting room and boss room filled in 
	# we can place the random assortment of base level rooms in 
	# our map
	place_base_rooms(scene, map_size, base_rooms)

	# Place a bunch of random non-overlapping rooms.
		# Chance for miniboss room
	# Fill in the remaining solid regions with mazes.
	# Connect each of the mazes and rooms to their neighbors, with a chance to add some extra connections.
	# Remove all of the dead ends.
	print("Dungeon generated!")
	
func place_room(scene: Node, room: Node, position: Vector2):
	room.position = position
	scene.add_child(room)
	
func place_character(room: Node, character: CharacterBody2D):
	var spawn = room.get_node("")
	character.position
	
# Responsible for placing all of the base rooms. This goes through the tilemap 
# to find empty tiles. We then (accounting for padding), select available rooms 
# at random. If they will fit into the map segment, we can go ahead and place them
func place_base_rooms(scene: TileMap, map_size: Vector2, base_rooms: Array):
	var maxRoomTries = 5
	
	# Generate a random X / Y offset. Why, who tf knows
	var x_offset = randi_range(0, map_size[0])
	var y_offset = randi_range(0, map_size[1])
	
	# Iterate through all the cells of the tilemap
	for x in map_size[0]:
		for y in map_size[1]:
			print("Coords: %s,%s" % [x,y])
			if current_rooms >= max_rooms:
				return
			place_base_room_at_cell(scene, x, y, base_rooms)
			
				
func place_base_room_at_cell(scene: TileMap, x: int, y: int, base_rooms: Array) -> void:
	var maxRoomTries = 5
	var tile_data = scene.get_cell_tile_data(0, Vector2(x, y))
	if tile_data:
		return

	for try in maxRoomTries:
		# Grab a random room
		var room = base_rooms[randi_range(0, base_rooms.size() - 1)].instantiate()
		var size = room.get_used_rect().size
		if not is_range_empty(
			scene,
			Vector2i(x, x+size[0]),
			Vector2i(y, y+size[1]),
		):
			# Room doesn't fit in the open space. 
			# Remove the instance and continue
			room.queue_free()
			continue
			
		# Hooray! The room will fit in our tilemap!
		room.position = Vector2(x, y)
		scene.add_child(room)
		current_rooms += 1
		fill_ground_tiles(scene, Vector2i(x, y), Vector2i(x + size[0], y + size[1]))
		return

func is_range_empty(scene: TileMap, start: Vector2i, end: Vector2i) -> bool:
	for x in range(start[0], end[0]):
		for y in range(start[1], end[1]):
			var tile_data = scene.get_cell_tile_data(0, Vector2(x, y))
			if tile_data:
				return false
	return true
	
# HACK: Since we're adding "scenes" and not tilemaps, we're going to go ahead 
# and just dump blank ground tiles on the base whenever we place a room. This way 
# later rooms can 
# TODO: We should just store the map of cells that we've placed, and we can 
# check them for collisions later
func fill_ground_tiles(scene: TileMap, start: Vector2i, end: Vector2i) -> void:
	var ground_tile_coords = Vector2i(2, 5)
	var ground_tile_source = 3
	for x in range(start[0], end[0]):
		for y in range(start[1], end[1]):
			scene.set_cell(0, Vector2i(x, y), ground_tile_source, ground_tile_coords)
			
