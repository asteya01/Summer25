extends Node2D


const ENEMY_BULLET = preload("res://Scenes/Bullets/EnemyBullet.tscn")
const PLAYER_BULLET = preload("res://Scenes/Bullets/PlayerBullet.tscn")

func _ready() -> void:
	#await get_tree().create_timer(2.0).timeout
	#SignalHub.emit_on_boss_killed()
	pass
