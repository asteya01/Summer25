extends Control


const HIGHSCORE_DISPLAY = preload("res://Scenes/HighscoreDisplay/HighscoreDisplay.tscn")


@onready var grid_container: GridContainer = $MarginContainer/GridContainer


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") == true:
		GameManager.load_next_level()


func set_scores() -> void:
	for score: HighScore in GameManager.high_scores.get_scores_list():
		var hsd: HighScoreDisplayItem = HIGHSCORE_DISPLAY.instantiate()
		hsd.setup(score)
		grid_container.add_child(hsd)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	set_scores()
