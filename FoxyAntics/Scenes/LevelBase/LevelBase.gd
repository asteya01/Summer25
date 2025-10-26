extends Node2D


const ENEMY_BULLET = preload("res://Scenes/Bullets/EnemyBullet.tscn")
const PLAYER_BULLET = preload("res://Scenes/Bullets/PlayerBullet.tscn")

func _ready() -> void:
	get_tree().paused = false
	pass
