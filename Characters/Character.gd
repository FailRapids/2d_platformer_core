extends KinematicBody2D

var state_stack = []

enum STATE_IDS {
				NULL=0, PREVIOUS_STATE=1, 
				IDLE=2, MOVE=3, 
				JUMP=4, ATTACK=5,
				DIE=6, STAGGER=7,
			}

signal state_changed
signal direction_changed

onready var States = {
	IDLE: $'States/Idle',
	MOVE: $'States/Move',
	JUMP: $'States/Jump',
	ATTACK: $'States/Attack',
	STAGGER: $'States/Stagger',
	DIE: $'States/Die'
}

var look_direction = Vector2() setget ,get_look_direction
var move_direction = Vector2() setget ,get_move_direction

var velocity = Vector2() setget set_velocity, get_velocity
var air_velocity = Vector2() setget set_air_velocity, get_air_velocity

var speed = 0 setget set_speed, get_speed
var air_speed = 0 setget set_air_speed, get_air_speed

var height = 0.0 setget set_height, get_height

var mass = 0 setget set_mass, get_mass

func _ready():
 state_stack.push_front(States[IDLE])
 state_stack[0].enter()

func _process(delta):
	if not state_stack[0].has_method("update"):
		return
	var new_state = state_stack[0].update(delta)
	if new_state:
		go_to_state(new_state)

func _physics_process(delta):
	if not state_stack[0].has_method('physics_update'):
		return
	var new_state = state_stack[0].physics_update(delta)
	if new_state:
		go_to_state(new_state)

func go_to_state(new_state):
	match new_state:
		PREVIOUS_STATE:
			state_stack.pop_front().exit()
		ATTACK:
			state_stack.push_front(States[new_state])
		JUMP:
			state_stack.push_front(States[new_state])
		_:
			for i in range(len(state_stack)):
				state_stack.pop_front().exit()
			state_stack.push_front(States[new_state])
	emit_signal("state_changed",state_stack)
	state_stack[0].enter()

func _on_animation_finished( Anim ):
	if not state_stack[0].has_method('_on_animation_finished'):
		return
	var new_state = state_stack[0]._on_animation_finished(Anim)
	if new_state:
		go_to_state(new_state)
		
func _on_tween_finished(object,key):
	if not state_stack[0].has_method('_on_tween_finished'):
		return
	var new_state = state_stack[0]._on_tween_finished(object,key)
	if new_state:
		go_to_state(new_state)

func _on_health_changed(new_health):
	if  not state_stack[0].has_method("_on_health_changed"):
		return
	var new_state = state_stack.front()._on_health_changed(new_health)
	if new_state:
		go_to_state(new_state)

func _on_attack_finished():
	if not state_stack[0].has_method('_on_attack_finished'):
		return
	var new_state = state_stack[0]._on_attack_finished()
	if new_state:
		go_to_state(new_state)
		
func get_look_direction():
	pass
	
func get_move_direction():
	pass

#Just some surface area to help track errors
func get_speed():
	return speed

func set_speed(value):
	assert value >= 0
	speed = value

func get_air_speed():
	air_speed = speed
	return air_speed

func set_air_speed(value):
	self.speed = value	
	air_speed = value

func get_velocity():
	return velocity 

func set_velocity(value):
	velocity = value

func get_air_velocity():
	air_velocity = velocity
	return air_velocity

func set_air_velocity(value):
	self.velocity = value
	air_velocity = value

func get_height():
	return height

func set_height(value):
	assert value >= 0
	$"BodyPivot/Body".position.y = -value
	height = value

func get_mass():
	return mass

func set_mass(value):
	assert value >= 0
	mass = value	

func _on_tween_completed(object, key):
	pass # replace with function body
