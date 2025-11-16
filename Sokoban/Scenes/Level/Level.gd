extends Node2D


@onready var tile_layers = $TileLayers
@onready var floor_tiles = $TileLayers/Floor
@onready var walls_tiles = $TileLayers/Walls
@onready var targets_tiles = $TileLayers/Targets
@onready var boxes_tiles = $TileLayers/Boxes


var _tile_size: int = 0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		GameManager.load_main_scene()
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Level Loaded:", GameManager.get_level_selected())
	_tile_size = floor_tiles.tile_set.tile_size.x
	setup_level()


func clear_tiles() -> void:
	for tl in tile_layers.get_children():
		tl.clear()

func setup_level() -> void:
	var level_number: String = GameManager.get_level_selected()
	@warning_ignore("unused_variable")
	var level_layout: LevelLayout = \
		LevelData.get_level_data(level_number)
	clear_tiles()
	pass
