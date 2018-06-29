extends 'res://Characters/Player/States/_State.gd'

export(int) var MAX_SPEED = 200
export(int) var ACCELRATION =80
export(int) var DECCELRATION = 80

func enter(prev_state):
	_AnimationPlayer.play("Walk")


func exit():
	_AnimationPlayer.stop()

func update(delta):
	pass

func physics_update(delta):
	return move(delta,_Player.move_direction)

func handle_input(event):
	if Input.is_action_just_pressed("Jump"):
		return JUMP
	if Input.is_action_just_pressed("Attack"):
		return ATTACK
	if Input.is_action_pressed("Run"):
		return RUN
		
func move(delta,direction):
	_Player.move( delta, direction, MAX_SPEED, ACCELRATION, DECCELRATION)
	if _Player.move_direction == Vector2() and _Player.speed <= MAX_SPEED/.50:
		return IDLE 
	 






