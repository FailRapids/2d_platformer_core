extends "res://Characters/States/_State.gd"

func enter():
    _Enity.set_process_input(false)
    _Enity.set_physics_process(false)
    _Collision.disabled = true
    _AnimationPlayer.connect("animation_finshed", _Enity, "_on_animation_finshed")
    _AnimationPlayer.play("Die")

func exit():
    queue_free()

func update():
    pass

func handle_input():
    pass

func _on_animation_finshed(name):
    if name == "Die":
        return IDLE 

