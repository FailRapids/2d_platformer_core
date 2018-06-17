extends "res://Characters/States/_State.gd"
var knockback_direction = Vector2(-1,0)
export(float) var stagger_knockback = 40
const STAGGER_DURATION = 0.4

func enter():
	_connect()
	_Tween.interpolate_property(_Enity, 'position', _Enity.position, _Enity.position + stagger_knockback * -knockback_direction, STAGGER_DURATION, Tween.TRANS_QUAD, Tween.EASE_OUT)
	_AnimationPlayer.play("Stagger")

func exit():
	_disconnect()
	_AnimationPlayer.stop()



func i(object, key):
	if key == ":position":
		return IDLE

func _connect():
	_Tween.connect("tween_completed", _Enity, "_on_tween_finished")


func _disconnect():
	_Tween.disconnect("tween_completed", _Enity, "_on_tween_finished")
	
