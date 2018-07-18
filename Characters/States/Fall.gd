extends "res://Characters/States/_State.gd"
var step_force = Vector2()
var min_force = Vector2()
var max_force = Vector2()

func enter(prev_state):
	.enter(prev_state)

	if self.prev_state.name in ["Jump"]:
		self.step_force += prev_state.step_force
		self.min_force += prev_state.min_force
		self.max_force += prev_state.max_force
	_AnimationPlayer.play("Falling")

func exit():

	if self.prev_state.name in ["Jump"]:
		self.step_force -= prev_state.step_force
		self.min_force -= prev_state.min_force
		self.max_force -= prev_state.max_force

	.exit()
	_AnimationPlayer.stop()

func update(dt):
	.update(dt)

	if _Character.is_on_ground():
		return IDLE

func  physics_update(dt):
	fall(dt,_Character.move_direction)

func fall(dt,direction):
	_Character.velocity = _Character.move_and_slide(
		_Character.apply(dt,Vector2(step_force.x,0),Vector2(direction.x,0),
		_Character.apply(dt,GRAVITY["Force"],GRAVITY["Direction"],
		_Character.velocity.clamped(max_force.length())
		)))