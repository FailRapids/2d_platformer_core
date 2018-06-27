extends 'res://Characters/States/_State.gd'


func enter(prev_state):
	_AnimationPlayer.play('Idle')


func update(delta):
	pass

func physics_update(delta):
	pass

func exit():
	_AnimationPlayer.stop()

func handle_input(event):
	pass
