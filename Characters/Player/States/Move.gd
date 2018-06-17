extends 'res://Characters/Player/States/_State.gd'

export var MAX_SPEED = 60

export var ACCELRATION = 35
export var DECCELERATION = 60

export(float) var MASS = 15.0


func enter():
	_AnimationPlayer.play("Walk")
	
func update(delta):
	return move(delta,_Player.look_direction)

func exit():
	self.speed = 0
	self.mass = 0
	self.velocity = Vector2()
	_AnimationPlayer.stop()
	
func handle_input(event):
	if Input.is_action_just_pressed("Player_Jump"):
		return JUMP
	if Input.is_action_just_pressed("Player_Attack"):
		return ATTACK
		
func move(delta,direction):
	if _Player.move_direction != Vector2():
		self.speed = clamp(self.speed + (ACCELRATION * delta), self.speed, MAX_SPEED)
		self.mass =  clamp(self.mass + (ACCELRATION * delta), 15, MASS)
	else:
		self.speed = clamp(self.speed - (DECCELERATION * delta),0,self.speed)
		self.mass = clamp(self.mass - (DECCELERATION * delta), 1, self.mass)
		
	var steered_velocity = (direction * self.speed) - velocity
	
	self.velocity += (steered_velocity / self.mass) * STRENGTH
	_Player.move_and_slide(self.velocity)
	
	if _Player.move_direction == Vector2() and speed <= 5:
		return IDLE
	 






