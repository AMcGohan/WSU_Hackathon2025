extends Node2D

@export var FLOOR_TILE_ID: int = 0  # 0 is floor tiles
@export var WALL_TILE_ID: int = 1   # 1 is wall tiles
@export var FILLER_TILE_ID: int = 2 # 2 is filler tiles (add this export variable)
@export var player_scene: PackedScene  # Exposes a field in Inspector

# Define the size of the level (use the TileMap's dimensions)
@export var level_width: int = 20
@export var level_height: int = 20

func generate_level():
	# Clear the existing level (if any)
	$TileMap.clear()
	
	# Example: Generate a simple floor with walls and filler
	for x in range(level_width):  # Adjust the range for your level size
		for y in range(level_height):
			if x == 0 or x == level_width - 1 or y == 0 or y == level_height - 1:  # Create walls at the edges
				$TileMap.set_cell(0, Vector2i(x, y), WALL_TILE_ID, Vector2i(0, 0))
			elif x % 3 == 0 and y % 3 == 0:  # Example: Add filler tiles
				$TileMap.set_cell(0, Vector2i(x, y), FILLER_TILE_ID, Vector2i(0, 0))
			else:
				$TileMap.set_cell(0, Vector2i(x, y), FLOOR_TILE_ID, Vector2i(0, 0))
	
	print("Level generated with walls, floors, and filler!")

func get_valid_floor_positions():
	var tilemap = $TileMap  # Make sure your level has a TileMap node
	var floor_tiles = []
	
	for x in range(level_width):
		for y in range(level_height):
			var cell = Vector2i(x, y)
			if tilemap.get_cell_source_id(0, cell) == FLOOR_TILE_ID:
				floor_tiles.append(cell)
	
	return floor_tiles

func get_random_floor_position() -> Vector2:
	var floor_tiles = get_valid_floor_positions()
	
	if floor_tiles.size() == 0:
		print("No valid floor tiles found!")
		return Vector2.ZERO  

	# Make sure the random tile is within the map bounds
	var random_tile = floor_tiles[randi() % floor_tiles.size()]
	return $TileMap.map_to_local(random_tile)  # Convert to world position

func is_spawn_location_valid(position: Vector2) -> bool:
	# Convert world position to tile coordinates
	var tile_position = $TileMap.local_to_map(position)
	
	# Check if the tile is a floor tile
	if $TileMap.get_cell_source_id(0, tile_position) != FLOOR_TILE_ID:
		return false
	
	# Optional: Check only the immediate adjacent tiles (up, down, left, right)
	var directions = [Vector2i(0, -1), Vector2i(0, 1), Vector2i(-1, 0), Vector2i(1, 0)]
	for dir in directions:
		var neighbor_tile = tile_position + dir
		var neighbor_tile_id = $TileMap.get_cell_source_id(0, neighbor_tile)
		if neighbor_tile_id == WALL_TILE_ID or neighbor_tile_id == FILLER_TILE_ID:
			return false
	
	return true

func spawn_player():
	if player_scene:
		var player_instance = player_scene.instantiate()
		var spawn_position = find_valid_spawn_location()
		if spawn_position != Vector2.ZERO:
			player_instance.position = spawn_position
			add_child(player_instance)
		else:
			print("Error: No valid spawn location found!")

func find_valid_spawn_location() -> Vector2:
	var attempts = 100  # Maximum number of attempts to find a valid spawn
	for i in range(attempts):
		var spawn_position = get_random_floor_position()
		if is_spawn_location_valid(spawn_position):
			return spawn_position
	print("Failed to find a valid spawn location after", attempts, "attempts.")
	return Vector2.ZERO

func _ready():
	spawn_player()

func _process(delta: float) -> void:
	pass
