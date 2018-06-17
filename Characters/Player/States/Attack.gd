extends "res://Characters/Player/States/_State.gd"

export(PackedScene) var weapon_path = "res://Weapons/Weapon.tscn"

var weapon = null

func enter():
	_Enity.set_physics_process(false)
	var weapon_instance = weapon_path.instance()
	_WeaponSpawn.add_child(weapon_instance)
	weapon = _WeaponSpawn.get_child(0)
	weapon.connect("attack_finished", _Enity, "_on_attack_finished")
	weapon.go_to_state(3)
	
func exit():
	_Enity.set_physics_process(true)
#	weapon.disconnect("attack_finished", _Enity, "_on_attack_finished")
	
	
func update(delta):
	pass

func _on_animation_finished(Anim):
	pass

func _on_attack_finished():
	return IDLE

