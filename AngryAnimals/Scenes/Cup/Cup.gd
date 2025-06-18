extends StaticBody2D


class_name Cup

static var _num_cups: int = 0


@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_num_cups += 1

func die() -> void:
	animation_player.play("vanish")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	_num_cups -= 1
	SignalHub.emit_on_cup_destroyed(_num_cups)
	queue_free()
