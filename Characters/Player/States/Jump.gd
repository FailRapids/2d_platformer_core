extends "res://Characters/Player/States/_State.gd"

export var MAX_SPEED = 60
export var ACCELRATION = 35
export var DECCELERATION = 60
export var MASS = 15.0

export var JUMP_DURATION = 0.50
export var MAX_JUMP_HEIGHT = 8



func enter():
	_Collision.disabled = true
	_Tween.connect('tween_completed', _Player, "_on_tween_finished")
	_Tween.interpolate_method(self, "_animate_jump_height", 0, 1, JUMP_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_Tween.start()

func update(delta):
	jump(delta,_Player.look_direction)
	
func exit():
	_Collision.disabled = false
	_Tween.disconnect('tween_completed', _Player,'_on_tween_finished')
	
func jump(delta,direction):
	if _Player.move_direction != Vector2():
		self.air_speed = clamp(self.air_speed + (ACCELRATION * delta),15,MAX_SPEED)
		self.mass = clamp(self.mass + (ACCELRATION * delta),10,MASS)
	else:
		self.air_speed =clamp(self.air_speed - (DECCELERATION * delta), 0,self.air_speed)
		self.mass = clamp(self.mass - (DECCELERATION * delta), 10, self.mass)
	
	var steered_velocity = (direction * self.air_speed) - self.air_velocity
	self.air_velocity += (steered_velocity / self.mass) * STRENGTH
	
	_Player.move_and_slide(self.air_velocity)
	
func _animate_jump_height(progress):
	self.height = (pow(sin(progress * PI), 0.5) * MAX_JUMP_HEIGHT)
	
func _on_tween_finished(object,key):
	if key == ":_animate_jump_height":
		return PREVIOUS_STATE
