extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var hb_hearts = $MarginContainer/HBHearts

var _score: int = 0
var _hearts: Array




func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit") == true:
		GameManager.load_main()




func _ready() -> void:
	_hearts = hb_hearts.get_children()
	_score = GameManager.cached_score
	on_scored(0)

func _enter_tree() -> void:
	SignalHub.on_scored.connect(on_scored)
	SignalHub.on_player_hit.connect(on_player_hit)

func _exit_tree() -> void:
	GameManager.try_add_new_score(_score)

func on_player_hit(lives: int, shake: bool) -> void:
	for i in range(_hearts.size()):
		_hearts[i].visible = lives > i
	if lives <= 0:
		level_over(false)

func level_over(complete: bool) -> void:
	get_tree().paused = true    # Works now!

func on_scored(points: int) -> void:
	_score += points
	score_label.text = "%03d" % _score
