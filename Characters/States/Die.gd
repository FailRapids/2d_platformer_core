extends "res://Characters/States/_State.gd"

func enter():
    _Character.set_process_input(false)
    _Character.set_physics_process(false)
    _Collision.disabled = true
    _AnimationPlayer.play("Die")

func exit():
    _Character.queue_free()

func update(delta):
    pass
    
func handle_input():
    pass

func _on_animation_finished(name):
    if name == "Die":
        return IDLE
