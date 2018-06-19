extends "res://Characters/Character.gd"

func take_damage(attacker_weapon, amount):
	if self.is_a_parent_of(attacker_weapon):
		return
	$'States/Stagger'.knockback_direction = (attacker_weapon.global_position - global_position).normalized()
	$Health.damage(amount)