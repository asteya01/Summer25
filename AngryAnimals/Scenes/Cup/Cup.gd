extends StaticBody2D


class_name Cup

@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func die() -> void:
	animation_player.play("vanish")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
