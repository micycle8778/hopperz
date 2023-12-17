extends Node3D

@export var explode_power := 10.0

@onready var audio := $AudioStreamPlayer as AudioStreamPlayer

var hash_set = {}

func rnf() -> float:
	return -1 + (randf() * 2)

func _ready():
	for child in get_children():
		var body := child as RigidBody3D
		if body == null:
			continue

		body.apply_central_impulse(Vector3(rnf(), rnf(), rnf()) * explode_power)

		body.contact_monitor = true
		body.max_contacts_reported = 1

		body.body_entered.connect(func(_body):
			if not body in hash_set and _body.name == "Ground":
				hash_set[body] = true
				audio.play()
		)
