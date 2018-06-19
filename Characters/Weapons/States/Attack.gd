extends "res://Characters/Weapons/States/_State.gd"

enum ATTACK_INPUT_STATES { IDLE=2, LISTENING=0, REGISTERED=1 }
var attack_input_state = IDLE
var ready_for_next_attack = true
const MAX_COMBO_COUNT = 3
var combo_count = 0
var hit_objects = []

var attack_current = {}
var combo = [
	{
		'damage': 1,
		'animation': 'Attack_F'
	},
	{
		'damage': 1,
		'animation': "Attack_F"
	},
	{
		'damage': 3,
		'animation': 'Attack_M'
	}
]

func enter():
	_connect()
	attack_input_state = REGISTERED
	
	
func exit():
	_disconnect()
	_AnimationPlayer.stop()
	_Weapon.queue_free()

func update(delta):
	if attack_input_state == REGISTERED and ready_for_next_attack:
		attack()

func attack():
	combo_count += 1
	attack_current = combo[combo_count -1]
	_AnimationPlayer.play(attack_current['animation'])
	attack_input_state = LISTENING
	ready_for_next_attack = false
	
func handle_input(event):
	if attack_input_state != LISTENING:
		return
	if Input.is_action_just_pressed('Player_Attack'):
		attack_input_state = REGISTERED

func _on_animation_finished(anim):
	if not attack_current:
		return

	if attack_input_state == REGISTERED and combo_count < MAX_COMBO_COUNT:
		attack()
	else:
		_Weapon.emit_signal("attack_finished")
		return IDLE

func _on_body_entered(body):
	if body.get_rid().get_id() in hit_objects:
		return
	if body.has_node("Health"):
		hit_objects.append(body.get_rid().get_id())
		body.take_damage(_Weapon, attack_current['damage'])
	
func _connect():
	_AnimationPlayer.connect('animation_finished', _Weapon, "_on_animation_finished")
	_Weapon.connect("body_entered", _Weapon, "_on_body_entered")

func _disconnect():
	_AnimationPlayer.disconnect('animation_finished', _Weapon, "_on_animation_finished")
	_Weapon.disconnect("body_entered", _Weapon, "_on_body_entered")
