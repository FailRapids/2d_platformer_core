extends Node

signal status_changed(_dict)

enum STATE_IDS {
				NULL=0, PREVIOUS_STATE, IDLE, MOVE, 
				JUMP, ATTACK, DIE, STAGGER
				}

onready var _Enity = $"../.."

onready var _BodyPivot = $"../..".get_node("BodyPivot")
onready var _WeaponPivot = $"../..".get_node("WeaponPivot")
onready var _CameraPivot = $"../..".get_node("CameraPivot")

onready var _Collision = $"../..".get_node("Collision")

onready var _AnimationPlayer = $"../..".get_node("AnimationPlayer")
onready var _Tween = $"../..".get_node("Tween")
onready var _WeaponSpawn =$"../..".get_node("WeaponPivot/WeaponSpawn")

var speed = 0 setget set_speed,get_speed
var air_speed = 0 setget set_air_speed,get_air_speed

var velocity = Vector2() setget set_velocity,get_velocity
var air_velocity = Vector2() setget set_air_velocity,get_air_velocity

var height = 0.0 setget set_height

var mass = 0

export(int,1,10) var STRENGTH = 5

func enter():
	pass

func exit():
	pass
	
func update(delta):
	pass
	
func handle_input(event):
	pass
		
func _on_animation_finished(name):
	pass

func _on_tween_finshed(object,key):
	pass

#wip remove 
#plese grab values from _Enity

func get_speed():#return float
	speed = _Enity.speed
	return speed
	
func set_speed(value):#value:int||float 
	speed = value
	_Enity.speed = speed
	
func get_air_speed():#return float
	air_speed = _Enity.air_speed
	return air_speed

func set_air_speed(value):
	air_speed = value
	_Enity.air_speed =  air_speed
	
func get_velocity():
	velocity = _Enity.velocity
	return velocity
	
func set_velocity(value):
	velocity = value
	_Enity.velocity = value
	
func get_air_velocity():
	air_velocity = _Enity.air_velocity
	return air_velocity
	
func set_air_velocity(value):
	air_velocity = value
	_Enity.air_velocity = value
	_Enity.velocity = value
	

func get_height():
	height = _Enity.height
	return height

func set_height(value):
	height = value
	_Enity.height = value
	_BodyPivot.get_node("Body").position.y = -height

func get_mass():
	mass = _Enity.mass
	return mass
	
func set_mass(value):
	mass = value
	_Enity.mass = value
	