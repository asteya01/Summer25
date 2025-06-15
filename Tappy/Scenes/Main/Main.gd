extends Control

@onready var highscore_2: Label = $HIGHSCORE2

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and event.is_echo() == false:
		GameManager.load_game_scene()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	highscore_2.text = "%03d" % ScoreManager.high_score
