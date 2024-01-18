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

var placed_rooms = []
var placed_positions = []

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
	print(placed_rooms)
	print(placed_positions)
	print("Dungeon generated!")
	
func place_room(scene: Node, room: Node, position: Vector2):
	print("Placing room at %s" % position)
	room.position = position
	scene.add_child(room)
	
	# Store the vector coords so we can check collisions
	var size = room.get_used_rect().size
	placed_rooms.append([position, Vector2(position[0] + size[0], position[1] + size[1])])
	#print("Position: %s" % position)
	#print(placed_rooms)
	placed_positions.append(position)
	
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

	for try in maxRoomTries:
		# Grab a random room
		var room = base_rooms[randi_range(0, base_rooms.size() - 1)].instantiate()
		var size = room.get_used_rect().size
		print("Size: %s" % size)
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
		place_room(scene, room, Vector2(x, y))
		current_rooms += 1
		# fill_ground_tiles(scene, Vector2i(x, y), Vector2i(x + size[0], y + size[1]))
		return

func is_range_empty(scene: TileMap, start: Vector2i, end: Vector2i) -> bool:
	for x in range(start[0], end[0]):
		for y in range(start[1], end[1]):
			for placement in placed_rooms:
				if vector_in_between(Vector2i(x, y), placement[0], placement[1]):
					return false
	return true

func vector_in_between(cell: Vector2i, start: Vector2, end: Vector2):
	#print("Cell: %s" % cell)
	#print("Start: %s" % start)
	#print("End: %s" % end)
	if cell[0] >= start[0] and cell[0] <= end[0] and cell[1] >= start[1] and cell[1] <= end[1]:
		print("Vector found as in between")
		return true 
	return false
	
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
			
