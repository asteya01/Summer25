extends Control


const GAME_OVER = preload("uid://clry7aigdpjkk")
const YOU_WIN = preload("uid://cnx8nx64k6yuu")


@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var hb_hearts = $MarginContainer/HBHearts
@onready var color_rect = $ColorRect
@onready var vb_game_over = $ColorRect/VBGameOver
@onready var vb_complete = $ColorRect/VBComplete
@onready var complete_timer = $CompleteTimer
@onready var sound = $Sound



var _score: int = 0
var _hearts: Array
var _can_continue: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit") == true:
		GameManager.load_main()
	
	if _can_continue and event.is_action_pressed("shoot"):
		GameManager.load_main()
		




func _ready() -> void:
	_hearts = hb_hearts.get_children()
	_score = GameManager.cached_score
	on_scored(0)

func _enter_tree() -> void:
	SignalHub.on_scored.connect(on_scored)
	SignalHub.on_player_hit.connect(on_player_hit)
	SignalHub.on_level_complete.connect(on_level_complete)
	
	
func _exit_tree() -> void:
	GameManager.try_add_new_score(_score)

func on_player_hit(lives: int, shake: bool) -> void:
	for i in range(_hearts.size()):
		_hearts[i].visible = lives > i
	if lives <= 0:
		on_level_complete(false)

func on_level_complete(complete: bool) -> void:
	color_rect.show()
	
	if complete:
		vb_complete.show()
		sound.stream = YOU_WIN
	else:
		vb_game_over.show()
		sound.stream = GAME_OVER
		
	sound.play()
	get_tree().paused = true
	complete_timer.start()

func on_scored(points: int) -> void:
	_score += points
	score_label.text = "%03d" % _score


func _on_complete_timer_timeout():
	_can_continue = true
