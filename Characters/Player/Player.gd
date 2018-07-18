extends "res://Characters/Character.gd"

#use analog flag
export(bool) var use_analog = false

# in precent area from center 
export(Vector2) var analog_deadzone_size = Vector2(.1,.1) 

func _input(event):
	if not state_stack[0].has_method('handle_input'):
		return
	var new_state = state_stack[0].handle_input(event)
	if new_state: 
		go_to_state(new_state)
		

func get_move_direction():
	move_direction = Vector2()
	if not Input.get_connected_joypads().empty() and use_analog :
		var raw_analog = Vector2(
			Input.get_joy_axis(Input.get_connected_joypads().front(), JOY_AXIS_0),
			Input.get_joy_axis(Input.get_connected_joypads().front(), JOY_AXIS_1)
		) 

		if abs(raw_analog.x) < analog_deadzone_size.x:
			move_direction.x = 0
		else:
			move_direction.x = raw_analog.x

		if abs(raw_analog.y) < analog_deadzone_size.y:
			move_direction.y = 0
		else:
			move_direction.y = raw_analog.y

	else:
		if Input.is_action_pressed("Player_Left"):
			move_direction.x = -1
		elif Input.is_action_pressed("Player_Right"):
			move_direction.x = 1

		if Input.is_action_pressed("Player_Up"):
			move_direction.y = -1
		elif Input.is_action_pressed("Player_Down"):
			move_direction.y = 1

	emit_signal("direction_changed",move_direction)
	return move_direction
	

		

		
