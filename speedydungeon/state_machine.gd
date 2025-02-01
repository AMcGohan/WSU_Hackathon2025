extends Node

@export var initial_state : State

var current_state : State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta)
	
func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)
	
func on_child_transition(state, new_state_name):
	print("Transition request from:", state, "to:", new_state_name)
	if state != current_state:
		print("State doesn't match current state. Ignoring.")
		return
	
	var new_state = states.get(new_state_name)
	if !new_state:
		print("Invalid state:", new_state_name)
		return
	
	if current_state:
		print("Exiting state:", current_state)
		current_state.Exit()
	
	print("Entering new state:", new_state_name)
	new_state.Enter()
	current_state = new_state
