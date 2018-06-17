extends "res://Characters/Player/States/_State.gd"


func enter():
#	_AnimationPlayer.play("Idle")
	pass
	
func update(delta):
	if _Enity.move_direction != Vector2():return MOVE

func exit():
#	_AnimationPlayer.stop()
	pass

func handle_input(event):
	if Input.is_action_just_pressed("Player_Jump"):
		return JUMP
	if Input.is_action_just_pressed("Player_Attack"):
		return ATTACK