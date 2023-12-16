class_name RandoPos extends Node

@export var start_pos: Vector3
@export var end_pos: Vector3

@onready var parent := get_parent() as Node3D

func _ready():
	assert(parent != null)
	
	parent.position = lerp(start_pos, end_pos, randf())

