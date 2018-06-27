extends "res://Characters/Player/States/_State.gd"


func enter(prev_state):
	_AnimationPlayer.play("Idle")
	
func update(delta):
	if _Player.move_direction != Vector2():
		return MOVE

func exit():
	_AnimationPlayer.stop()
	

func handle_input(event):
	if Input.is_action_just_pressed("Jump"):
		return JUMP
	if Input.is_action_just_pressed("Attack"):
		return ATTACK
	