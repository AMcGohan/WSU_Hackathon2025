class_name HurtBox
extends Area2D

signal received_damage(damage: int)

@export var health: Health

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:  # Check if hitbox is not null
		health.take_damage(hitbox.damage)
		received_damage.emit(hitbox.damage)
		if health.health <= 0:
			health.health = 0
			queue_free()  # Despawn the enemy when health reaches 0
