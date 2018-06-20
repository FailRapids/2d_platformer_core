extends Node

signal health_changed
signal health_depleted

var health = 0
export(int) var max_health = 9

func _ready():
	connect("health_changed", $"..","_on_health_changed")
	health = max_health

func damage(amount):
	health -= amount
	health = max(0, health)
	emit_signal("health_changed", health)

func heal(amount):
	health += amount
	health = max(health, max_health)
	emit_signal("health_changed", health)
