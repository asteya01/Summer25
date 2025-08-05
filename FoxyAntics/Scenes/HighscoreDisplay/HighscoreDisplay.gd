extends VBoxContainer


class_name HighScoreDisplayItem


@onready var score_label: Label = $ScoreLabel
@onready var date_label: Label = $DateLabel


var _high_score: HighScore = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if _high_score == null:
		queue_free()
	else:
		score_label.text = "%03d" % _high_score.score
		date_label.text = _high_score.date_scored
		run_tween()


func run_tween() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate", Color("#ffffff", 1.0), 1.4)


func setup(high_score: HighScore) -> void:
	_high_score = high_score
