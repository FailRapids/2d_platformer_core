extends 'res://Characters/States/_State.gd'

export(Vector2) var min_force = Vector2(15,0) # min_x 15 pix/sec
export(Vector2) var max_force = Vector2(30,0)
export(Vector2) var step_force = Vector2(10,0) # 8 pix/sec and 0 pix/sec 



func enter(prev_state):
	.enter(prev_state)
	_AnimationPlayer.play("Walk")

func exit():
	.exit()
	_Character.velocity.x = 0 
	_AnimationPlayer.stop()

func update(dt):
	.update(dt)
	
func physics_update(dt): 
	var direction = _Character.move_direction
	return Walk(dt,direction)

func Walk(dt,direction):
	if abs(direction.x) >= .25 and direction.x != 0:
		_Character.velocity= _Character.move_and_slide(
			_Character.apply(dt, step_force,Vector2(direction.x, 0),
			_Character.apply(dt, GRAVITY["Force"], GRAVITY["Direction"],
			_Character.velocity.clamped(max_force.length())
		)))		
		return	
	
	elif abs(_Character.velocity.x) >= min_force.x and abs(direction.x) <.25:
		_Character.velocity= _Character.move_and_slide(
			_Character.apply(dt,step_force*1.5,Vector2(0,0),
			_Character.apply(dt,GRAVITY["Force"],GRAVITY["Direction"],
			_Character.velocity.clamped(max_force.length())
		)))
		return

	elif abs(_Character.velocity.x) <= min_force.x and abs(direction.x) <.25:
		return IDLE


	






