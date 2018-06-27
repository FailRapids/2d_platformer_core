extends "res://Characters/Player/States/_State.gd"

export var JUMP_DURATION = 0.50
export var MAX_JUMP_HEIGHT = 8



func enter(prev_state):
	_Tween.connect('tween_completed', _Player, "_on_tween_finished")
	_Tween.interpolate_method(self, "_animate_jump_height", 0, 1, JUMP_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_Tween.start()

func physics_update(delta):
	$'../Move'.move(delta,_Player.move_direction)
	
	
func exit():
	_Tween.disconnect('tween_completed', _Player,'_on_tween_finished')
	

	
func _animate_jump_height(progress):
	_Player.height = (pow(sin(progress * PI), 0.5) * MAX_JUMP_HEIGHT)
	
func _on_tween_finished(object,key):
	if key == ":_animate_jump_height":
		return PREVIOUS_STATE
