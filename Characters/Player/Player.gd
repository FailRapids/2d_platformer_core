extends "res://Characters/Character.gd"

#Not Realy Needed
var INPUT_MAP = {
				"Up":"Player_Up",
				"Down":"Player_Down",
				"Left":"Player_Left",
				"Right":"Player_Right",
				}

func _input(event):
	if not state_stack[0].has_method('handle_input'):
		return
	var new_state = state_stack[0].handle_input(event)
	if new_state:
		go_to_state(new_state)
		
#Also in Monster.gd
func take_damage(attacker_weapon, amount):
	if self.is_a_parent_of(attacker_weapon):
		return
	$'States/Stagger'.knockback_direction = (attacker_weapon.global_position - global_position).normalized()
	$Health.damage(amount)

func get_look_direction():
	var last = look_direction
	look_direction = Vector2()
	
	if Input.is_action_pressed(INPUT_MAP["Up"]):
		look_direction.y = -1
	elif Input.is_action_pressed(INPUT_MAP["Down"]):
		look_direction.y = 1
	
	if Input.is_action_pressed(INPUT_MAP["Left"]):
		look_direction.x = -1
		$"BodyPivot/Body".flip_h = true
	elif Input.is_action_pressed(INPUT_MAP["Right"]):
		look_direction.x = 1
		$"BodyPivot/Body".flip_h = false
	
	if look_direction != Vector2():
		emit_signal("direction_changed",look_direction)
		return look_direction
	else:
		look_direction = last
		return last
	
func get_move_direction():
	var last = move_direction
	move_direction = Vector2()

	if Input.is_action_pressed(INPUT_MAP["Up"]):
		move_direction.y = -1
	elif Input.is_action_pressed(INPUT_MAP["Down"]):
		move_direction.y = 1
	
	if Input.is_action_pressed(INPUT_MAP["Left"]):
		move_direction.x = -1
		$"BodyPivot/Body".flip_h = true
	elif Input.is_action_pressed(INPUT_MAP["Right"]):
		move_direction.x = 1
		$"BodyPivot/Body".flip_h = false
		
	if move_direction != Vector2():
		emit_signal("direction_changed",move_direction)
		return move_direction
	else:
		return last
		