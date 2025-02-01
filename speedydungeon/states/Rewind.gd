extends State
class_name EnemyRewind

@export var enemy: CharacterBody2D

var replay_duration: float = 3.0
var rewind_values = {
	"position": [],
	"rotation": [],
	"velocity": []
}
var rewinding: bool = false

func Enter():
	print("EnemyRewind: Enter")
	rewinding = true
	if enemy.has_node("CollisionShape2D"):
		enemy.get_node("CollisionShape2D").set_deferred("disabled", true)

func Physics_Update(delta: float):
	print("EnemyRewind: Physics_Update")
	if rewind_values["position"].is_empty():
		if enemy.has_node("CollisionShape2D"):
			enemy.get_node("CollisionShape2D").set_deferred("disabled", false)
		Transitioned.emit(self, "EnemyFollow")  # Return to normal behavior
		return

	var pos = rewind_values["position"].pop_back()
	var rot = rewind_values["rotation"].pop_back()
	enemy.velocity = rewind_values["velocity"][-1] if rewind_values["velocity"].size() > 0 else Vector2.ZERO
	
	enemy.global_position = pos
	enemy.rotation = rot

func Exit():
	print("EnemyRewind: Exit")
	rewinding = false	

func SaveState():
	var max_size = replay_duration * Engine.get_physics_ticks_per_second()
	if rewind_values["position"].size() >= max_size:
		for key in rewind_values.keys():
			rewind_values[key].pop_front()
	
	rewind_values["position"].append(enemy.global_position)
	rewind_values["rotation"].append(enemy.rotation)
	rewind_values["velocity"].append(enemy.velocity)
