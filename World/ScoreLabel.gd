extends Label

func _ready():
	ScoreManager.current_score = 0
	ScoreManager.high_score_set = false

func _on_player_scored():
	ScoreManager.current_score += 1
	text = str(ScoreManager.current_score)

