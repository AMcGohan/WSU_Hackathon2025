extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Menu functions
func _on_settings_pressed() -> void:
	Global.savePrevScene(get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_file("res://UI/settings.tscn") # Load settings scene
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/menu.tscn") # Load settings scene
	pass # Replace with function body.
