extends Node

signal status_changed(_dict)

enum STATE_IDS {
				NULL=0, PREVIOUS_STATE=1,
				IDLE=2, MOVE=3, 
				JUMP=4, ATTACK=5, 
				DIE=6, STAGGER=7
				}

onready var _Character = $"../.."
onready var _BodyPivot = $"../../BodyPivot"
onready var _Collision = $"../../Collision"
onready var _AnimationPlayer = $"../../AnimationPlayer"
onready var _Tween = $"../../Tween"


export(int,1,10) var STRENGTH = 5

func enter():
	_connect()

func exit():
	_disconnect()
	
func update(delta):
	pass

func physics_update(delta):
	pass

func handle_input(event):
	pass

func _connect():
	pass
func _disconnect():
	pass

func _on_animation_finished(name):
	pass

func _on_tween_finshed(object,key):
	pass

func _on_health_changed(new_health):
	if new_health > 0:
		return STAGGER
	else:
		return DIE

func _on_attack_finished():
	pass