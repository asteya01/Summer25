extends Control


const GAME_OVER = preload("res://assets/audio/game_over.wav")


@onready var game_over: Label = $GameOver
@onready var press_label: Label = $PressLabel
@onready var timer: Timer = $Timer
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var sound: AudioStreamPlayer = $Sound

var _score: int = 0

func _ready() -> void:
	_score = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Exit"):
		GameManager.load_main_scene()
	elif press_label.visible == true and event.is_action_pressed("jump"):
		ScoreManager.high_score = _score
		GameManager.load_main_scene()

func _enter_tree() -> void:
	SignalHub.on_point_scored.connect(on_point_scored)
	SignalHub.on_plane_died.connect(on_plane_died)

func on_point_scored() -> void:
	sound.play()
	_score += 1
	score_label.text = "%03d" % _score

func on_plane_died() -> void:
	sound.stop()
	sound.stream = GAME_OVER
	sound.play()
	game_over.show()
	press_label.hide()
	timer.start()


func _on_timer_timeout() -> void:
	game_over.hide()
	press_label.show()
