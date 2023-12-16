extends Node3D

@export var start_point = -10
@export var distance = 10

var obstacles: Array[PackedScene]
const obstacles_path := "res://Obstacle/Obstacles/"

@onready var obstacles_parent = $Obstacles

func _ready():
	var dir := DirAccess.open(obstacles_path)
	
	if dir != null:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var scene := load(obstacles_path + file_name) as PackedScene

			assert(scene != null)
			obstacles.push_back(scene)

			file_name = dir.get_next()
	
	for i in range(100):
		var obstacle := (obstacles.pick_random() as PackedScene).instantiate() as Obstacle
		obstacle.position = Vector3(0, 0, start_point - i * distance) 
		obstacles_parent.add_child(obstacle)
