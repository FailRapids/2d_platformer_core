extends "res://Characters/Player/States/_State.gd"

export(PackedScene) var weapon_path = "res://Weapons/Weapon.tscn"

var weapon = null

func enter(prev_state):
	_Player.set_process_input(false)
	_spawn_weapon()

func exit():
	_Player.set_process_input(true)

func physics_update(delta):
	$'../Move'.move(delta,_Player.move_direction)

func _spawn_weapon():
	var weapon_instance = weapon_path.instance()
	_WeaponSpawn.add_child(weapon_instance)
	weapon = _WeaponSpawn.get_child(0)
	weapon.connect("attack_finished", _Player, "_on_attack_finished")
	weapon.go_to_state(3)
		
func _on_attack_finished():
	return IDLE

