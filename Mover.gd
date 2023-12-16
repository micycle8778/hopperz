class_name Mover extends Node

@export var start_pos: Vector3
@export var end_pos: Vector3
@export var speed := 3.0

@onready var duration = (end_pos - start_pos).length() / speed
@onready var t := randf()
@onready var parent := get_parent() as Node3D

func _ready():
	assert(parent != null)

	#process_mode = Node.PROCESS_MODE_ALWAYS

func _physics_process(delta):
	if t > 1:
		t = 0

	if t < 0.5:
		parent.position = lerp(start_pos, end_pos, t * 2)
	else:
		parent.position = lerp(end_pos, start_pos, (t - 0.5) * 2)
	
	t += delta / duration
