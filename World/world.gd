extends Node3D

@export var start_point = -10
@export var distance = 15

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

func _on_player_scored():
	Engine.time_scale += 0.05

func _on_tree_exiting():
	Engine.time_scale = 1
	get_tree().paused = false

func _on_player_killed():
	await get_tree().process_frame

	Engine.time_scale = 1
	$DeathMenu.visible = true
	get_tree().paused = true

	PhysicsServer3D.set_active(true)

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

