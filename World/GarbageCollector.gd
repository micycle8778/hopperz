extends Area3D

func _on_body_entered(body: Node3D):
	if body is Player:
		body.kill()

func _on_area_exited(area: Area3D):
	if area is Obstacle:
		area.queue_free()

