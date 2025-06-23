extends Control


@onready var music: AudioStreamPlayer = $Music
@onready var main: Control = $Main
@onready var game: Control = $Game


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_game_exit_pressed()



func _enter_tree() -> void:
	SignalHub.on_level_selected.connect(on_level_selected)
	SignalHub.on_game_exit_pressed.connect(on_game_exit_pressed)


func show_game(s: bool) -> void:
	game.visible = s
	main.visible = !s
	
	
func on_level_selected(level_num: int) -> void:
	SoundManager.play_sound(music, SoundManager.SOUND_IN_GAME)
	show_game(true)

func on_game_exit_pressed() -> void:
	SoundManager.play_sound(music, SoundManager.SOUND_MAIN_MENU)
	show_game(false)
