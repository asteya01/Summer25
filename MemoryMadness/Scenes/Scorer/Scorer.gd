extends Node


class_name Scorer


static var SelectionEnabled: bool = true


@onready var sound: AudioStreamPlayer = $Sound
@onready var reveal_timer: Timer = $RevealTimer


var _selections: Array[MemoryTile]
var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0


func _enter_tree() -> void:
	SignalHub.on_tile_selected.connect(on_tile_selected)
	SignalHub.on_game_exit_pressed.connect(on_game_exit_pressed)


func get_moves_made_str() -> String:
	return str(_moves_made)


func get_pairs_made_str() -> String:
	return "%d/%d" % [_pairs_made, _target_pairs]


func clear_new_game(target_pairs: int) -> void:
	_selections.clear()
	_target_pairs = target_pairs
	_moves_made = 0
	_pairs_made = 0
	SelectionEnabled = true


func check_for_pair() -> void:
	_moves_made += 1
	if _selections[0].matches_other_tile(_selections[1]) == true:
		_selections[0].kill_on_success()
		_selections[1].kill_on_success()
		_pairs_made += 1
		SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)


func process_pair() -> void:
	if _selections.size() != 2:
		return
	
	SelectionEnabled = false
	reveal_timer.start()
	check_for_pair()


func check_game_over() -> void:
	if _pairs_made == _target_pairs:
		SelectionEnabled = false
		SignalHub.emit_on_game_over(_moves_made)
	else:
		SelectionEnabled = true


func on_tile_selected(tile: MemoryTile) -> void:
	if tile in _selections:
		return
		
	_selections.append(tile)
	SoundManager.play_tile_click(sound)
	process_pair()


func on_game_exit_pressed() -> void:
	reveal_timer.stop()


func _on_reveal_timer_timeout() -> void:
	for s in _selections:
		s.reveal(false)
	_selections.clear()
	check_game_over()
