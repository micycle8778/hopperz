extends Label

@export var high_score_color: Color

func _on_player_killed():
	text = "High score: " + str(ScoreManager.high_score)

	if ScoreManager.high_score_set:
		text = "New high score: " + str(ScoreManager.high_score)
		add_theme_color_override("font_color", high_score_color)

