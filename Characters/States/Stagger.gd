extends "res://Characters/States/_State.gd"

var knockback_direction = Vector2(-1,0)

export(float) var stagger_knockback = 20
export(float,0,1) var STAGGER_DURATION = 0.5

func enter(prev_state):
	_Character.set_process_input(false)
	_Character.set_physics_process(false)
	_Collision.disabled = true
	_Tween.interpolate_property(_Character, 'position', _Character.position, _Character.position + stagger_knockback * -knockback_direction, STAGGER_DURATION, Tween.TRANS_QUAD, Tween.EASE_OUT)
	_AnimationPlayer.play("Stagger")
	_Tween.start()
	
func exit():

	_Character.set_process_input(true)
	_Character.set_physics_process(true)
	_Collision.disabled = false
	_AnimationPlayer.stop()

func update(delta):
	pass

func physics_update(delta):
	pass

func _on_animation_finished(name):
	if name == "Stagger":
		return IDLE

func _on_tween_finished(object, key):
	if key == ":position":
		return IDLE


