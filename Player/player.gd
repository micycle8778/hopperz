class_name Player extends CharacterBody3D

signal scored
signal killed

#@export var gravity := 9.8
@export var move_accel := 90.0

@export var jump_height := 3.0
@export var jump_duration := .5 

@export var ground_friction := 20.0
@export var air_friction := 10.0

# v_f = v_0 + at
# 0 = v_0 + at
# v_0 = -at

# x_f = x_0 + (v_0)t + (1/2)at^2
# height = 0 - at^2 + (1/2)at^2
# height / t^2 = (1/2)a - a
# height / t^2 = (-1/2)a
# height / t^2 * -2 = a

var gravity := jump_height / (jump_duration ** 2) * 2
var jump_power := gravity * jump_duration

var is_dead := false

@onready var starting_z := global_position.z

func _physics_process(delta):
	position.z = max(starting_z, position.z)

	if not is_on_floor():
		velocity += gravity * Vector3.DOWN * delta
	elif Input.is_action_just_pressed("jump"):
		velocity += Vector3.UP * jump_power
	
	if is_on_floor():
		velocity.x = lerpf(velocity.x, 0, ground_friction * delta)
	else:
		velocity.x = lerpf(velocity.x, 0, air_friction * delta)
	
	if Input.is_action_pressed("move_left"):
		velocity += Vector3.LEFT * move_accel * delta
	if Input.is_action_pressed("move_right"):
		velocity += Vector3.RIGHT * move_accel * delta
	
	velocity.z = -abs(global_position.z - starting_z)

	move_and_slide()

func score():
	if not is_dead:
		scored.emit()

func kill():
	is_dead = true

	var dead_player := preload("res://Player/fractured_player.tscn") as PackedScene
	assert(dead_player != null)

	var obj = dead_player.instantiate()
	obj.position = position + Vector3(0, 1, 0)
	get_parent().add_child(obj)
	queue_free()

	killed.emit()
