extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Start button
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://level.tscn") # <-- Change the scene to load here
	pass # Replace with function body.

# Settings
func _on_settings_pressed() -> void:
	pass # Replace with function body.

# How to Play Button
func _on_instructions_pressed() -> void:
	pass # Replace with function body.

# Login Button
func _on_login_pressed() -> void:
	pass # Replace with function body.

# Exit
func _on_exit_pressed() -> void:
	get_tree().quit()
