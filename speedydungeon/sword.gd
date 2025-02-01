extends Node2D

@export var distance_from_player: float = 25.0  # Adjust distance as needed
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
	var player = get_parent()
	if not player:
		return
	
	# Get direction from player to mouse
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - player.global_position).normalized()
	
	# Set sword position relative to player
	global_position = player.global_position + direction * distance_from_player

	# Rotate sword to face mouse
	look_at(mouse_position)

	# Flip the sword when on the left side of the player
	if mouse_position.x < player.global_position.x:
		scale.y = -0.5  # Flip upside down
		scale.x = 0.5
	else:
		scale.y = 0.5   # Keep normal
		scale.x = 0.5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		swing_sword()

func swing_sword() -> void:
	if animation_player:
		animation_player.play("swing")
