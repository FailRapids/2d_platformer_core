extends "res://Characters/States/_State.gd"

func enter():
    _Character.set_process_input(false)
    _Character.set_physics_process(false)
    _Collision.disabled = true
    _AnimationPlayer.connect("animation_finshed", _Character, "_on_animation_finshed")
    _AnimationPlayer.play("Die")

func exit():
#    queue_free()
	pass
func update(delta):
    _Health.heal(100)

func handle_input():
    pass

func _on_animation_finshed(name):
    if name == "Die":
        return IDLE 
