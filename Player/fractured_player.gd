extends Node3D

@export var explode_power := 10.0

func rnf() -> float:
	return -1 + (randf() * 2)

func _ready():
	for child in get_children():
		var body := child as RigidBody3D
		if body == null:
			continue

		body.apply_central_impulse(Vector3(rnf(), rnf(), rnf()) * explode_power)
