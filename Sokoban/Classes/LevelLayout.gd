class_name LevelLayout


var _player_start: Vector2i = Vector2i.ZERO
var _tile_layers: TileLayers = TileLayers.new()


func add_tile_to_layer(tx: int, ty: int, lt: TileLayers.LayerType) -> void:
	_tile_layers.add_coord(Vector2i(tx, ty), lt)


func set_player_start(tile_x: int, tile_y: int) -> void:
	_player_start = Vector2i(tile_x, tile_y)

	
func get_player_start() -> Vector2i:
	return _player_start
	

func get_tiles_for_layer(lt: TileLayers.LayerType) -> Array[Vector2i]:
	return _tile_layers.get_tiles_for_layer(lt)
