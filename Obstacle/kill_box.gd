class_name Killbox extends Area3D

signal kill

func _on_body_entered(body):
	var player := body as Player
	if player != null:
		player.kill()
