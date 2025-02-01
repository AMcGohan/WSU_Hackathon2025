class_name Health
extends Node

signal max_health_changed(diff: int)
signal health_changed(diff:int)
signal health_depleted

@export var max_health: int = 100
@onready var health: int = max_health

func set_max_health(value: int):
	var clamped_value = 10 if value <= 0 else value
	
	if not clamped_value == max_health:
		var difference = clamped_value - max_health 
		max_health = value
		max_health_changed.emit()
		if health > max_health:
			health = max_health
	
func get_max_health() -> int:
	return max_health
	
func get_health():
	return health
