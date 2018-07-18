extends KinematicBody2D
#TODO seperate state machice 

var state_stack = []

enum STATE_IDS {
	NULL=0,
	PREVIOUS_STATE=1, 
	CLEAR=2,
	IDLE, 
	WALK,
	RUN, 
	JUMP, 
	FALL,
}
			
signal update_gui(status)
signal state_changed(state)
signal direction_changed(direction)

onready var States = {
	IDLE: $'States/Idle',
	WALK: $'States/Walk',
	FALL: $'States/Fall',
	RUN: $'States/Run',
	JUMP: $'States/Jump',
	
}

var move_direction = Vector2() setget ,get_move_direction
var velocity = Vector2() setget set_velocity, get_velocity

func _ready():
 state_stack.push_front(States[IDLE])
 state_stack[0].enter(state_stack.front())

func _process(delta):
	if not state_stack[0].has_method("update"):
		return
	var new_state = state_stack[0].update(delta)
	if new_state:
		go_to_state(new_state)

func _physics_process(delta):
	if not state_stack[0].has_method('physics_update'):
		return 
	var new_state = state_stack[0].physics_update(delta*2)
	if new_state:
		go_to_state(new_state)

func go_to_state(new_state):
	var prev_state = state_stack.front()
	
	match new_state:
		NULL:
			breakpoint
		PREVIOUS_STATE:
			state_stack.pop_front().exit()
		JUMP,FALL:
			
			state_stack.push_front(States[new_state])
		IDLE,WALK,RUN:
			for i in range(len(state_stack)):
				state_stack.pop_front().exit()
			state_stack.push_front(States[new_state])
	
	emit_signal("state_changed",state_stack)
	state_stack[0].enter(prev_state)

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

	
func apply(dt, force=Vector2(), direction=Vector2(), velocity=Vector2()): #returns Vector2()	
	if (sign(direction.x) != sign(velocity.x)) and abs(velocity.x) != 0:
		if sign(direction.x) != 0:
			velocity.x = abs(velocity.x)/2 * direction.x
#dead i think
#	if (sign(direction.y) !=  sign(velocity.y)) and abs(velocity.y) != 0:
#		if sign(direction.y) != 0:
#			velocity.y = velocity.y* direction.y

	var new_velocity = velocity
	force *= dt

	if direction.x != 0 :
		new_velocity.x += force.x * direction.normalized().x
	else:
		new_velocity.x -= force.x * velocity.normalized().x
	
	if direction.y != 0:
		new_velocity.y += force.y * direction.normalized().y
	else:
		new_velocity.y -= force.y * velocity.normalized().y
	
	var steered_velocity = new_velocity + (new_velocity-velocity)
	
	return steered_velocity
	
func is_on_ground():
	return $Normal.is_colliding()
		
func get_move_direction():
	return Vector2()
	
func get_velocity():
	
	return velocity 

func set_velocity(value):
	assert typeof(value) == TYPE_VECTOR2
	velocity = value





