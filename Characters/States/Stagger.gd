extends "res://Characters/States/_State.gd"

var knockback_direction = Vector2(-1,0)

export(float) var stagger_knockback = 40
export(float,0,1) var STAGGER_DURATION = 0.4

func enter():
	_connect()
	_Tween.interpolate_property(_Character, 'position', _Character.position, _Character.position + stagger_knockback * -knockback_direction, STAGGER_DURATION, Tween.TRANS_QUAD, Tween.EASE_OUT)
	_AnimationPlayer.play("Stagger")
	_Tween.start()
	
func exit():
	_disconnect()
	_AnimationPlayer.stop()

func update(delta):
	pass

func physics_update(delta):
	pass

func _on_animation_finished(name):
	pass

func _on_tween_finished(object, key):
	if key == ":position":
		return IDLE


func _connect():
	_Tween.connect("tween_completed", _Character, "_on_tween_finished")

func _disconnect():
	_Tween.disconnect('tween_completed', _Character, '_on_tween_finished')
	
