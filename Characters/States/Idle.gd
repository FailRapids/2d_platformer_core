extends 'res://Characters/States/_State.gd'



func enter(prev_state):
	.enter(prev_state)
	
	_AnimationPlayer.play("Idle")
	
func exit():
	.exit()
	_Character.velocity = Vector2()
	_AnimationPlayer.stop()

func update(dt):
	.update(dt)
	
	if _Character.move_direction.x != 0:
		return WALK

func physics_update(dt):
	_Character.velocity = _Character.move_and_slide(
		_Character.apply(dt,GRAVITY["Force"],GRAVITY["Direction"],
		_Character.velocity.clamped(GRAVITY["Force"].length()*2)
		))

