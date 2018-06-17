extends 'res://Characters/States/_State.gd'

export var MAX_SPEED = 60

export var ACCELRATION = 35
export var DECCELERATION = 60

export(float) var MASS = 15.0

func enter():
	_AnimationPlayer.play("Walk")
	
func update(delta):
	return move(delta,_Enity.look_direction)
	
func exit():
	self.speed = 0
	self.mass = 0
	self.velocity = Vector2()
	_AnimationPlayer.stop()
	
func move(delta,direction):
	if _Enity.move_direction != Vector2():
		self.speed = clamp(self.speed + (ACCELRATION * delta), self.speed, MAX_SPEED)
		self.mass =  clamp(self.mass + (ACCELRATION * delta), self.mass, MASS)
	else:
		self.speed = clamp(self.speed - (DECCELERATION * delta), 0, self.speed)
		self.mass = clamp(self.mass - (DECCELERATION * delta), 1, MASS)
		
	var steered_velocity = (direction * self.speed) - velocity
	
	self.velocity += (steered_velocity / self.mass) * STRENGTH
	_Enity.move_and_slide(self.velocity)
	
	if _Enity.move_direction == Vector2() and speed <= 5:
		return IDLE
