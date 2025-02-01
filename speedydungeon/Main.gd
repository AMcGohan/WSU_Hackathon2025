extends Node2D

@export var level_generation: Node2D
@export var player_scene: PackedScene
@export var pause_menu: PackedScene

var player: Node2D
var menu: Control

func _ready():
	# Generate the level
	level_generation.generate_level()
	
	# Spawn the player
	spawn_player()

func spawn_player():
	var spawn_point = level_generation.get_random_floor_position()
	if spawn_point != Vector2.ZERO:
		player = player_scene.instantiate()
		menu = pause_menu.instantiate()
		player.position = spawn_point
		add_child(player)
		player.add_child(menu)
	else:
		print("Error: No valid spawn point found!")
