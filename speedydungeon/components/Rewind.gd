extends CharacterBody2D

class_name Rewind

var replay_duration: float = 3.0
var rewinding: bool = false
var rewind_values = {
	"position": [],
	"rotation": [],
	"velocity": []
}

func _physics_process(delta: float) -> void:
	move_and_slide()

	if not rewinding:
		var max_size = replay_duration * Engine.get_physics_ticks_per_second()
		if rewind_values["position"].size() >= max_size:
			for key in rewind_values.keys():
				rewind_values[key].pop_front()
		
		rewind_values["position"].append(global_position)
		rewind_values["rotation"].append(rotation)
		rewind_values["velocity"].append(self.velocity)
	else:
		compute_rewind(delta)

func rewind() -> void:
	rewinding = true
	if has_node("CollisionShape2D"):
		print("Disabling CollisionShape2D for " + str(self))
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		print("No CollisionShape2D for " + str(self))

func compute_rewind(delta: float) -> void:
	if rewind_values["position"].is_empty():
		# Re-enable collision shape after rewinding
		if has_node("CollisionShape2D"):
			print("Re-enabling CollisionShape2D for " + str(self))
			$CollisionShape2D.set_deferred("disabled", false)
		else:
			print("No CollisionShape2D for " + str(self))

		rewinding = false
		return

	var pos = rewind_values["position"].pop_back()
	var rot = rewind_values["rotation"].pop_back()
	self.velocity = rewind_values["velocity"][-1] if rewind_values["velocity"].size() > 0 else Vector2.ZERO
	
	global_position = pos
	rotation = rot
