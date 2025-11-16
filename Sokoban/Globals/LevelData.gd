extends Node


const LEVEL_DATA_PATH: String = "res://Data/level_data.json"


var _level_data: Dictionary = {}


func _enter_tree() -> void:
	load_level_data()
	

func add_tiles_for_layer(layout: LevelLayout,
						layer_type: TileLayers.LayerType,
						tile_coords: Array) -> void:
	for tc in tile_coords:
		layout.add_tile_to_layer(tc.x, tc.y, layer_type)


func setup_level(ln: String, raw_level_data: Dictionary) -> LevelLayout:
	var layout: LevelLayout = LevelLayout.new()
	var raw_tiles: Dictionary = raw_level_data.tiles
	var player_start: Dictionary = raw_level_data.player_start
	
	add_tiles_for_layer(layout, TileLayers.LayerType.Floor, raw_tiles.Floor)
	add_tiles_for_layer(layout, TileLayers.LayerType.Walls, raw_tiles.Walls)
	add_tiles_for_layer(layout, TileLayers.LayerType.Boxes, raw_tiles.Boxes)
	add_tiles_for_layer(layout, TileLayers.LayerType.TargetBoxes, raw_tiles.TargetBoxes)
	add_tiles_for_layer(layout, TileLayers.LayerType.Targets, raw_tiles.Targets)
	
	layout.set_player_start(player_start.x, player_start.y )
	
	return layout


func load_level_data() -> void:
	var file: FileAccess = FileAccess.open(LEVEL_DATA_PATH, FileAccess.READ)
	
	if !file:
		return
		
	var json_data: Dictionary = JSON.parse_string(file.get_as_text())
	for ln in json_data.keys():
		var level_data = json_data[ln]
		_level_data[ln] = setup_level(ln, level_data)


func get_level_data(ln: String) -> LevelLayout:
	return _level_data[ln]
