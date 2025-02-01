extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("rewind"):
		rewind()

func rewind() -> void:
	$Player.rewind()
	for kobold in get_tree().get_nodes_in_group("kobolds"):
		kobold.rewind()
