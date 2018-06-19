extends 'res://Characters/States/_State.gd'

export var MAX_SPEED = 60

export var ACCELRATION = 35
export var DECCELERATION = 60

export(float) var MASS = 15.0

func enter():
	_AnimationPlayer.play("Walk")
	
func update(delta):
	return move(delta,_Character.look_direction)
	
func exit():
	_Character.speed = 0
	_Character.mass = 0
	_Character.velocity = Vector2()
	_AnimationPlayer.stop()
	
func move(delta,direction):
	if _Character.move_direction != Vector2():
		_Character.speed = clamp(_Character.speed + (ACCELRATION * delta), _Character.speed, MAX_SPEED)
		_Character.mass =  clamp(_Character.mass + (ACCELRATION * delta), _Character.mass, MASS)
	else:
		_Character.speed = clamp(_Character.speed - (DECCELERATION * delta), 0, _Character.speed)
		_Character.mass = clamp(_Character.mass - (DECCELERATION * delta), 1, MASS)
		
	var steered_velocity = (direction * _Character.speed) - _Character.velocity
	
	_Character.velocity += (steered_velocity / _Character.mass) * STRENGTH
	_Character.move_and_slide(_Character.velocity)
	
	if _Character.move_direction == Vector2() and _Character.speed <= 5:
		return IDLE
