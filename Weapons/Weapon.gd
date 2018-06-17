extends Area2D

var states = []

enum STATE_IDS {NULL=0, PREVIOUS_STATE=1, IDLE=2, ATTACK=3}

signal attack_finished

onready var States = {
	IDLE: $"States/Idle",
	ATTACK: $"States/Attack"
}

func _ready():
	states.push_front(States[IDLE])
	states[0].enter()

func _physics_process(delta):
	if not states[0].has_method('update'):
		return
	var new_state = states[0].update(delta)
	if new_state:
		go_to_state(new_state)

func _input(event):
	if not states[0].has_method("handle_input"):
		return
	var new_state = states[0].handle_input(event)
	if new_state:
		go_to_state(new_state)

func go_to_state(new_state):
	states[0].exit()
	match new_state:
		PREVIOUS_STATE:
			states.pop_front()
		_:
			states[0] = States[new_state]
	states[0].enter()

func _on_body_entered(body):
	if not states[0].has_method("_on_body_entered"):
		return
	var new_state = states[0]._on_body_entered(body)
	if new_state:
		go_to_state(new_state)

func _on_animation_finished(anim):
	if not states[0].has_method('_on_animation_finished'):
		return
	var new_state = states[0]._on_animation_finished(anim)
	if new_state:
		go_to_state(new_state)
		
func set_attack_input_listening():
	$States/Attack.attack_input_state = 0


# use with AnimationPlayer func track
func set_ready_for_next_attack():
	$States/Attack.ready_for_next_attack = true
