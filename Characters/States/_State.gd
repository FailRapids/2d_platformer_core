extends Node


enum{
	NULL=0,
	PREVIOUS_STATE=1,
	CLEAR=2,
	IDLE,
	WALK, 
	RUN,
	JUMP, 
	FALL,
}

export(Dictionary) var GRAVITY = {
	"Force":Vector2(0, 10),
	"Direction":Vector2(0,1),
	}

onready var _Character = $"../.."
onready var _AnimationPlayer = $"../../AnimationPlayer"
onready var _Tween = $"../../Tween"

var prev_state
var time_in_state = 0
func enter(prev_state):
	self.prev_state = prev_state

func exit():
	self.time_in_state = 0
	self.prev_state = null
	
func update(dt):
	self.time_in_state += dt

func physics_update(dt):
	pass

func _on_animation_finished(name):
	pass

func _on_tween_finshed(object,key):
	pass
