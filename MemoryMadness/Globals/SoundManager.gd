extends Node


const SOUND_MAIN_MENU: String = "main"
const SOUND_IN_GAME: String = "ingame"
const SOUND_SUCCESS: String = "success"
const SOUND_GAME_OVER: String = "gameover"
const SOUND_SELECT_TILE: String = "tile"
const SOUND_SELECT_BUTTON: String = "button"


const SOUNDS: Dictionary[String, AudioStream] = {
	SOUND_MAIN_MENU: preload("res://assets/sounds/bgm_action_3.mp3"),
	SOUND_IN_GAME: preload("res://assets/sounds/bgm_action_4.mp3"),
	SOUND_SUCCESS: preload("res://assets/sounds/sfx_sounds_fanfare3.wav"),
	SOUND_GAME_OVER: preload("res://assets/sounds/sfx_sounds_powerup12.wav"),
	SOUND_SELECT_TILE: preload("res://assets/sounds/sfx_sounds_impact1.wav"),
	SOUND_SELECT_BUTTON: preload("res://assets/sounds/sfx_sounds_impact7.wav")
}


func play_sound(player: AudioStreamPlayer, key: String) -> void:
	if SOUNDS.has(key) == false:
		return
		
	player.stop()
	player.stream = SOUNDS[key]
	player.play()


func play_button_click(player: AudioStreamPlayer) -> void:
	play_sound(player, SOUND_SELECT_BUTTON)


func play_tile_click(player: AudioStreamPlayer) -> void:
	play_sound(player, SOUND_SELECT_TILE)
