extends Node


const GAME = preload("res://Scenes/Game/Game.tscn")
const MAIN = preload("res://Scenes/Main/Main.tscn")


func load_game_scene() -> void:
	get_tree().change_scene_to_packed(GAME)


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)
