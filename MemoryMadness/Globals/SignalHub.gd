extends Node


signal on_level_selected(level_num: int)
signal on_game_exit_pressed
signal on_tile_selected(tile: MemoryTile)
signal on_game_over(moves_taken: int)


func emit_on_game_over(moves_taken: int) -> void:
	on_game_over.emit(moves_taken)


func emit_on_level_selected(level_num: int) -> void:
	emit_signal("on_level_selected", level_num)

func emit_on_game_exit_pressed() -> void:
	on_game_exit_pressed.emit()

func emit_on_tile_selected(tile: MemoryTile) -> void:
	on_tile_selected.emit(tile)
