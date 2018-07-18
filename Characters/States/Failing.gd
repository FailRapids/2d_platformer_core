extends "res://Characters/States/_State.gd"
var step_force = Vector2()
var min_force = Vector2()
var max_force = Vector2()

func enter(prev_state):
	.enter(prev_state)
	
	if self.prev_state.name in ["Jump"]:
		pass
	
	_AnimationPlayer.play("Falling")

func exit():
	.exit()
	_AnimationPlayer.stop()

func update(dt):
	.update(dt)
	
	if _Character.is_on_ground():
		return IDLE

func  physics_update(dt):
	fall(dt,Vector2())

func fall(dt,direction):
	_Character.velocity = _Character.move_and_slide(
		_Character.apply(dt,GRAVITY["Force"],GRAVITY["Direction"],
		_Character.velocity.clamped(GRAVITY["Force"].length()
		)))