extends 'res://Characters/Player/States/_State.gd'

export var MAX_SPEED = 60
export var RUN_SCALE = 2.5
export var ACCELRATION = 35
export var DECCELERATION = 60

export(float) var MASS = 15.0


func enter():
	_AnimationPlayer.play("Walk")
	
func update(delta):
	return move(delta,_Player.move_direction)

func exit():
	_Player.speed = 0
	_Player.mass = 0
	_Player.velocity = Vector2()
	_AnimationPlayer.stop()
	
func handle_input(event):
	if Input.is_action_just_pressed("Jump"):
		return JUMP
	if Input.is_action_just_pressed("Attack"):
		return ATTACK
	if Input.is_action_just_pressed("Run"):
		MAX_SPEED = MAX_SPEED * RUN_SCALE
	elif Input.is_action_just_released("Run"):
		MAX_SPEED = MAX_SPEED / RUN_SCALE
		
func move(delta,direction):
	if direction != Vector2():
		_Player.speed = clamp(_Player.speed + (ACCELRATION * delta), _Player.speed, MAX_SPEED)
		_Player.mass =  clamp(_Player.mass + (ACCELRATION * delta), 15, MASS)
	else:
		_Player.speed = clamp(_Player.speed - (DECCELERATION * delta),0,_Player.speed)
		_Player.mass = clamp(_Player.mass - (DECCELERATION * delta), 1, _Player.mass)
		
	var steered_velocity = (direction * _Player.speed) - _Player.velocity
	
	_Player.velocity += (steered_velocity / _Player.mass) * STRENGTH
	_Player.move_and_slide(_Player.velocity)
	
	if _Player.move_direction == Vector2() and _Player.speed <= 5:
		return IDLE
	 






