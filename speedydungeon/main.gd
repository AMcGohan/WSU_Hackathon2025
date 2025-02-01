extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("rewind"):
		rewind()

func rewind() -> void:
	$Player.rewind()
