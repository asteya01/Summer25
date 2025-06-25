extends Control


@onready var moves_label: Label = $NPR/VBC/MovesLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_game_over.connect(on_game_over)
	SignalHub.on_game_exit_pressed.connect(on_game_exit_pressed)


func on_game_over(moves_made: int) -> void:
	moves_label.text = "You took %d moves" % moves_made
	show_game_over_after_delay()

func on_game_exit_pressed() -> void:
	hide()

func show_game_over_after_delay():
	await get_tree().create_timer(1).timeout
	show()
