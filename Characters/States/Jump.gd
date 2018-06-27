extends "res://Characters/States/_State.gd"
export var MAX_SPEED = 60

export var ACCELRATION = 35
export var DECCELERATION = 60

export(float) var MASS = 15.0
export var JUMP_DURATION = 0.50
export var MAX_JUMP_HEIGHT = 8



func enter(prev_state):
	_Collision.disabled = true
	_Tween.interpolate_method(self, '_animate_jump_height', 0, 1, JUMP_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_Tween.start()

func update(delta):
	jump(delta,_Character.look_direction)
	
func exit():
	_Collision.disabled = false
	
func jump(delta,direction):
	if _Character.move_direction != Vector2():
		self.air_speed = clamp(self.air_speed + (ACCELRATION * delta),15,MAX_SPEED)
		self.mass = clamp(self.mass + (ACCELRATION * delta),1,MASS)
	else:
		self.air_speed =clamp(self.air_speed - (DECCELERATION * delta), 0,self.air_speed)
		self.mass = clamp(self.mass - (DECCELERATION * delta), 1, self.mass)
	
	var steered_velocity = (direction * self.air_speed) - self.air_velocity
	self.air_velocity += (steered_velocity / self.mass) * STRENGTH
	_Character.move_and_slide(self.air_velocity)
	
func _animate_jump_height(progress):
	self.height = (pow(sin(progress * PI), 0.5) * MAX_JUMP_HEIGHT)
	
func _on_tween_finished(object,key):
	if key == ":_animate_jump_height":
		return IDLE
