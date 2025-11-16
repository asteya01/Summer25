extends Control

const LEVEL_BUTTON = preload("res://Scenes/LevelButton/LevelButton.tscn")
const LEVELS_COUNT: int = 30


@onready var grid_container = $MC/VB/GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	setup_grid()


func setup_grid() -> void:
	for level in range(LEVELS_COUNT):
		var lb: LevelButton = LEVEL_BUTTON.instantiate()
		lb.setup(str(level+1))
		grid_container.add_child(lb)
