class_name Obstacle extends Area3D

@export var move_speed := 5

func _physics_process(delta):
	position.z += move_speed * delta


func _on_body_exited(body):
	var player := body as Player
	if player != null:
		player.score()
