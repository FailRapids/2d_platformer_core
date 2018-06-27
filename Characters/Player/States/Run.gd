extends "res://Characters/Player/States/_State.gd"


export(int) var MAX_SPEED = 200
export(int) var ACCELRATION =80
export(int) var DECCELRATION = 80

export var max_run_time = 10
export var animation_speed = 1.5

var prev_playback_speed = 0

func enter(prev_state):
    prev_playback_speed = _AnimationPlayer.playback_speed
    _AnimationPlayer.playback_speed = animation_speed
    $RunTimer.wait_time = max_run_time
    $RunTimer.connect("timeout",_Player,"_on_timer_timeout")
    $RunTimer.start()

func exit():
    _AnimationPlayer.playback_speed = prev_playback_speed
    $RunTimer.stop()
    $RunTimer.disconnect("timeout",_Player,"_on_timer_timeout")
    _AnimationPlayer.stop()

func handle_input(event):
    if Input.is_action_just_released("Run"):
        return PREVIOUS_STATE

func update(delta):
    pass 

func physics_update(delta):
    return move(delta,_Player.move_direction)

func move(delta,direction):
    _Player.move(delta,direction,MAX_SPEED,ACCELRATION, DECCELRATION)
    if _Player.move_direction == Vector2() and _Player.speed <= MAX_SPEED/1.25 :
        return PREVIOUS_STATE

func _on_timer_timeout():
    return 1
