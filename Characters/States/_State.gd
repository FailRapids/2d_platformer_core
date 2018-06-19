extends Node

signal status_changed(_dict)

enum STATE_IDS {
				NULL=0, PREVIOUS_STATE=1,
				IDLE=2, MOVE=3, 
				JUMP=4, ATTACK=5, 
				DIE=6, STAGGER=7
				}

onready var _Character = $"../.."

onready var _BodyPivot = $"../..".get_node("BodyPivot")
onready var _WeaponPivot = $"../..".get_node("WeaponPivot")
onready var _CameraPivot = $"../..".get_node("CameraPivot")

onready var _Collision = $"../..".get_node("Collision")

onready var _AnimationPlayer = $"../..".get_node("AnimationPlayer")
onready var _Tween = $"../..".get_node("Tween")
onready var _WeaponSpawn =$"../..".get_node("WeaponPivot/WeaponSpawn")

onready var _Health = $"../../Health"

export(int,1,10) var STRENGTH = 5

func enter():
	pass

func exit():
	pass
	
func update(delta):
	pass

func physics_update(delta):
	pass

func handle_input(event):
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