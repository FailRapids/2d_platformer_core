extends 'res://Characters/States/_State.gd'

export(int) var MAX_SPEED = 200
export(int) var ACCELRATION =80
export(int) var DECCELRATION = 80

func enter(prev_state):
	_AnimationPlayer.play("Walk")

func exit():
	_AnimationPlayer.stop()	

func update():
	pass

func physics_update(delta):
	return move(delta,_Character.move_direction)
	

	
func move(delta,direction):
	_Character.move(delta,direction,MAX_SPEED,ACCELRATION,DECCELRATION)
	if _Character.move_direction == Vector2() and _Character.speed <= 5:
		return IDLE
