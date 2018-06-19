extends "res://Characters/Weapons/States/_State.gd"


func enter():
	_AnimationPlayer.play("Idle")
	_Weapon.monitoring = false

func exit():
	_AnimationPlayer.stop()
	_Weapon.monitoring = true

func update(delta):
	pass

func handle_input(event):
	pass
