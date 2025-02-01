extends CharacterBody2D

const SPEED = 1000.0
const ACCEL = 5.0

var input: Vector2

func get_input():
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return input.normalized()
	
func _process(delta):
	var playerInput = get_input()
	
	velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)
	
	move_and_slide()
	
