extends Node2D

@export var level_generation: Node2D
@export var player_scene: PackedScene

var player: Node2D

func _ready():
	# Generate the level
	level_generation.generate_level()
	
	# Spawn the player
	spawn_player()

func spawn_player():
	var spawn_point = level_generation.get_random_floor_position()
	if spawn_point != Vector2.ZERO:
		player = player_scene.instantiate()
		player.position = spawn_point
		add_child(player)
	else:
		print("Error: No valid spawn point found!")
