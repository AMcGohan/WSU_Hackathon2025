extends Node2D

@export var FLOOR_TILE_ID : int = 0  # 0 is floor tiles
@export var player_scene: PackedScene  # Exposes a field in Inspector

func generate_level():
	# Clear the existing level (if any)
	$TileMap.clear()
	
	# Example: Generate a simple floor
	for x in range(10):  # Adjust the range for your level size
		for y in range(10):
			$TileMap.set_cell(0, Vector2i(x, y), FLOOR_TILE_ID, Vector2i(0, 0))
	
	print("Level generated!")
	
func get_valid_floor_positions():
	var tilemap = $TileMap  # Make sure your level has a TileMap node
	var floor_tiles = []
	
	for cell in tilemap.get_used_cells(0):  # Layer 0 (change if needed)
		if tilemap.get_cell_source_id(0, cell) == FLOOR_TILE_ID:
			floor_tiles.append(cell)
	
	return floor_tiles

func get_random_floor_position():
	var floor_tiles = get_valid_floor_positions()
	
	if floor_tiles.size() == 0:
		print("No valid floor tiles found!")
		return Vector2.ZERO  
	
	var random_tile = floor_tiles[randi() % floor_tiles.size()]
	return $TileMap.map_to_local(random_tile)  # Convert to world position
	
## Called when the node enters the scene tree for the first time.


func _ready():
	pass

func spawn_player():
	if player_scene:
		var player_instance = player_scene.instantiate()
		player_instance.position = find_spawn_location()  # We'll define this next
		add_child(player_instance)

func find_spawn_location():
	return get_random_floor_position()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
