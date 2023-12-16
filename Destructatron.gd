class_name Destructatron extends Node

func _ready():
	get_parent().queue_free()
