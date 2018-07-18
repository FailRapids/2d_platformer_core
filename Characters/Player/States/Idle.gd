extends "res://Characters/States/Idle.gd"

func update(dt):
	.update(dt)
	
	if _Character.move_direction.x != 0:
		return WALK
		
func handle_input(event):
	if Input.is_action_just_pressed("Jump"):
		return JUMP

	