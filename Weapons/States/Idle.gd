extends "res://Weapons/States/_State.gd"


func enter():
	_AnimationPlayer.play("Idle")
	_Enity.monitoring = false

func exit():
	_AnimationPlayer.stop()
	_Enity.monitoring = true

func update(delta):
	pass

func handle_input(event):
	pass
