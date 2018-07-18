extends "res://Characters/States/_State.gd"




export(Vector2) var step_force = Vector2()
export(Vector2) var min_force = Vector2()
export(Vector2) var max_force = Vector2()

export(float) var JUMP_DURATION = .5
export(int) var max_height = 0
var _init_height
var height = 0

func enter(prev_state):
	.enter(prev_state)
	self._init_height = _Character.position.y

	if self.prev_state.name in ["Walk", "Run"]:
		self.step_force.x += self.prev_state.step_force.x
		self.max_force.x += self.prev_state.max_force.x
	
	_AnimationPlayer.play("Jump")
	
func exit():
	
	if self.prev_state.name in ["Walk", "Run"]:
		self.step_force.x -= self.prev_state.step_force.x
		self.max_force.x -= self.prev_state.max_force.x
	
	.exit()
	_AnimationPlayer.stop()

func update(dt):
	.update(dt)
	self.height = _Character.position.y
	
	if abs(height - _init_height) > 10:
		return FALL

func physics_update(delta):
	if prev_state.name in ["IDLE"]:
		jump(delta,Vector2())
	else:
		jump(delta,_Character.move_direction*.5)

func jump(dt,direction):
	#todo jump should be based of height
	_Character.velocity = _Character.move_and_slide(
		_Character.apply(dt,step_force,Vector2(direction.x,-1),
		_Character.velocity.clamped(max_force.length())
		))

