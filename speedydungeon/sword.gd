extends Node2D

@export var distance_from_player: float = 25.0  
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var flipped: bool = false  # Track if the sword is flipped

func _process(delta: float) -> void:
	var player = get_parent()
	if not player:
		return
	
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - player.global_position).normalized()
	
	global_position = player.global_position + direction * distance_from_player
	look_at(mouse_position)

	# Flip sword when it's on the left
	if mouse_position.x < player.global_position.x:
		scale.y = -0.5  
		scale.x = 0.5
		flipped = true
	else:
		scale.y = 0.5   
		scale.x = 0.5
		flipped = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		swing_sword()

func swing_sword() -> void:
	animation_player.play("swing")
	if flipped:
		animation_player.set_speed_scale(1)  # Reverse playback
	else:
		animation_player.set_speed_scale(1)  # Normal playback
