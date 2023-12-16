class_name Player extends CharacterBody3D

signal scored
signal killed

@export var gravity := 9.8
@export var move_accel := 60.0

@export var jump_height := 1.5
@export var jump_duration := 0.5

@export var ground_friction := 20.0
@export var air_friction := 15.0

# x_f = x_0 + (v_0)t + (1/2)at^2
# height = 0 + vt + (1/2)at^2
# height = t(v + (1/2)at)
# height / t = v + (1/2)at
# (height / t) - (1/2)at = v

var jump_power = (jump_height / jump_duration) \
				 - (0.5 * -gravity * jump_duration)

func _physics_process(delta):
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
	
	move_and_slide()

func score():
	print("scored")
	scored.emit()

func kill():
	print("killed")
	killed.emit()
