extends Node

const save_filename := "user://high-score.dat"

var write_file: FileAccess
var high_score_set := false

var high_score := 0:
	set(v):
		if write_file == null: return 

		write_file.seek(0)
		write_file.store_32(v)
		write_file.flush()

		high_score = v

var current_score := 0:
	set(v):
		if v > high_score:
			high_score = v
			high_score_set = true

		current_score = v


func _ready():
	var read_file := FileAccess.open(save_filename, FileAccess.READ)
	if read_file != null:
		high_score = read_file.get_32()
		read_file.close()
	
	write_file = FileAccess.open(save_filename, FileAccess.WRITE)
