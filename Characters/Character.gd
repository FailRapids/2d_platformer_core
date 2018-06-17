extends KinematicBody2D

var stack = []

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
	stack.push_front(States[IDLE])
	stack[0].enter()

func _process(delta):
	pass

func _physics_process(delta):
	if not stack[0].has_method('update'):
		return
	var new_state = stack[0].update(delta)
	if new_state:
		go_to_state(new_state)

func _on_health_changed(new_health):
	pass

func go_to_state(new_state):
	match new_state:
		PREVIOUS_STATE:
			stack.pop_front().exit()
		ATTACK:
			stack.push_front(States[new_state])
		JUMP:
			stack.push_front(States[new_state])
		_:
			for i in range(len(stack)):
				stack[i].exit()
			stack.push_front(States[new_state])
	
	stack[0].enter()

func _on_animation_finished( Anim ):
	if not stack[0].has_method('_on_animation_finished'):
		return
	var new_state = stack[0]._on_animation_finished(Anim)
	if new_state:
		go_to_state(new_state)
		
func _on_tween_finished(object,key):
	if not stack[0].has_method('_on_tween_finished'):
		return
	var new_state = stack[0]._on_tween_finished(object,key)
	if new_state:
		go_to_state(new_state)

func _on_attack_finished():
	if not stack[0].has_method('_on_attack_finished'):
		return
	var new_state = stack[0]._on_attack_finished()
	if new_state:
		go_to_state(new_state)
		
func get_look_direction():
	var last = look_direction
	look_direction = Vector2()
	
	if look_direction != Vector2():
		return look_direction
	else:
		return last
	
func get_move_direction():
	var last = move_direction
	move_direction = Vector2()
	if move_direction != Vector2():
		return move_direction
	else:
		return last

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
	assert typeof(value) == TYPE_VECTOR2
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
	height = value

func get_mass():
	return mass

func set_mass(value):
	assert value >= 0
	mass = value	