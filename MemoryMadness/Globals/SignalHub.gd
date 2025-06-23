extends Node


signal on_level_selected(level_num: int)
signal on_game_exit_pressed


func emit_on_level_selected(level_num: int) -> void:
	emit_signal("on_level_selected", level_num)

func emit_on_game_exit_pressed() -> void:
	on_game_exit_pressed.emit()
