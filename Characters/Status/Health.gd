extends Node

signal health_changed

signal update_gui(health,max_health)

onready var _Character = $"../.."

export(int) var max_health = 9

func _ready():
	connect("health_changed", _Character, "_on_health_changed")
	_Character.health = max_health

func _process(delta):
	emit_signal("update_gui", _Character.health, max_health)

func damage(amount):
	_Character.health -= amount
	_Character.health = max(0, _Character.health)
	emit_signal("health_changed", _Character.health)

func heal(amount):
	_Character.health += amount
	_Character.health = max(_Character.health, max_health)
	emit_signal("health_changed", _Character.health)
