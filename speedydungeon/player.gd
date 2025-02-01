extends CharacterBody2D


@export var health: Health

const SPEED = 1000.0
const ACCEL = 5.0


var speed: float = 600.0
var dir: Vector2 = Vector2.ZERO
var accel: float = 10.0
var friction: float = 8.0

var replay_duration: float = 3.0
var rewinding: bool = false
var rewind_values = {
	"position": [],
	"rotation": [],
	"velocity": []
}


func _ready():
	# Connect the health_depleted signal to a function
	health.health_depleted.connect(_on_player_death)

func _on_player_death():
	print("Player has died. Closing game...")
	get_tree().quit()
func _process(delta: float) -> void:
	if rewinding:
		return
	
	dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	dir = dir.normalized()
	if dir.length() > 0:
		self.velocity = lerp(self.velocity, dir * speed, accel * delta)
	else:
		self.velocity = lerp(self.velocity, Vector2.ZERO, friction * delta)

	look_at(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	move_and_slide()  # No arguments needed in Godot 4

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
	$CollisionShape2D.set_deferred("disabled", true)

func compute_rewind(delta: float) -> void:
	if rewind_values["position"].is_empty():
		$CollisionShape2D.set_deferred("disabled", false)
		rewinding = false
		return

	var pos = rewind_values["position"].pop_back()
	var rot = rewind_values["rotation"].pop_back()
	self.velocity = rewind_values["velocity"][-1] if rewind_values["velocity"].size() > 0 else Vector2.ZERO
	
	global_position = pos
	rotation = rot
