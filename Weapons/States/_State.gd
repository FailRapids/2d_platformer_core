extends Node


enum STATE_IDS {NULL, PREVIOUS_STATE, IDLE, ATTACK}

onready var _Enity = $"../.."
onready var _AnimationPlayer = $"../..".get_node("AnimationPlayer")
onready var _Collison = $"../..".get_node("Collision")

func enter():
	pass

func exit():
	pass
	
func update(delta):
	pass
	
func handle_input(event):
	pass

func _on_body_entered(body):
	pass

func _on_animation_finished(name):
	pass

