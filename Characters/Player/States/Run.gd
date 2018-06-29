extends "res://Characters/Player/States/_State.gd"


export(int) var MAX_SPEED = 200
export(int) var ACCELRATION =80
export(int) var DECCELRATION = 80

export var duration = 10
export var cooldown = 3
export var animation_speed = 1.5



func enter(prev_state):
	breakpoint
	if $Cooldown.is_stopped():
		_AnimationPlayer.playback_speed = animation_speed
		$Duration.start(duration)


func exit():
	if $Cooldown.is_stopped():
		_AnimationPlayer.playback_speed = 1
		$Cooldown.start()
	$Duration.stop()
	_AnimationPlayer.stop()

func handle_input(event):
	if Input.is_action_just_released("Run"):
		$Cooldown.wait_time = 0.01
		return PREVIOUS_STATE

func update(delta):
	pass

func physics_update(delta):
	return run(delta,_Player.move_direction)

func run(delta,direction):
	_Player.move(delta,direction,MAX_SPEED,ACCELRATION, DECCELRATION)
	if _Player.move_direction == Vector2() and _Player.speed <= MAX_SPEED/.50 :
		$Cooldown.wait_time = 0.01
		return PREVIOUS_STATE

func _on_timer_timeout():
	$Cooldown.wait_time = cooldown
	return PREVIOUS_STATE
