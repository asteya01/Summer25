class_name TileLayers


enum LayerType { Floor, Walls, Targets, Boxes, TargetBoxes }


var _floor: Array[Vector2i]
var _wall: Array[Vector2i]
var _boxes: Array[Vector2i]
var _targets: Array[Vector2i]
var _target_boxes: Array[Vector2i]


var _layer_coords: Dictionary = {
	LayerType.Floor: _floor,
	LayerType.Walls: _wall,
	LayerType.Targets: _targets,
	LayerType.Boxes: _boxes,
	LayerType.TargetBoxes: _target_boxes,
}


func add_coord(coord: Vector2i, lt: LayerType) -> void:
	_layer_coords[lt].push_back(coord)
	pass


func get_tiles_for_layer(lt: LayerType) -> Array[Vector2i]:
	return _layer_coords[lt]
