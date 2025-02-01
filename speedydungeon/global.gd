# This script manages all interactions between scripts of various scenes and hold global values
# i.e. Settings, Health between levels, etc

extends Node

var prevScene = '' 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		pause()
	pass

# Inter scene functions
# Saves previous scene, for loadPrevScene can load it
func savePrevScene(scene) -> void:
	prevScene = scene

# Loads previous scene, so same settings scene can be shared between menu and pause menu, etc
func loadPrevScene() -> void:
	get_tree().change_scene_to_file(prevScene) # Load scene
	pass

# Menu functions
func pause() -> void:
	$/root/Main/player/PauseMenu.show()
	get_tree().paused = true
	pass

func _on_resume_pressed() -> void:
	$/root/Main/player/PauseMenu.hide()
	get_tree().paused = false
	pass # Replace with function body.
