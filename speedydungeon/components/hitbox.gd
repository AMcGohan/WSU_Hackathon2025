extends Area2D
class_name HitBox
@export var damage: int = 20 : set = set_damage,  get = get_damage

func set_damage(value: int):
	damage = value
	
func get_damage() -> int:
	return damage
