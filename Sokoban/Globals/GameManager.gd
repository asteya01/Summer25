extends Node


const LEVEL = preload("res://Scenes/Level/Level.tscn")
const MAIN = preload("res://Scenes/Main/Main.tscn")


var _level_selected: String = "1"

func get_level_selected() -> String:
	return _level_selected


func load_level_scene(ln: String) -> void:
	_level_selected = ln
	get_tree().change_scene_to_packed(LEVEL)


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)
