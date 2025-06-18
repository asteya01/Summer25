extends Node


const FRAME_IMAGES: Array[Texture2D] = [
	preload("res://assets/blue_frame.png"),
	preload("res://assets/green_frame.png"),
	preload("res://assets/red_frame.png"),
	preload("res://assets/yellow_frame.png")
]

var _image_list: Array[Texture2D]


func _enter_tree() -> void:
	var ifl: ImageFilesListResource = load("res://Resources/image_files_list.tres")
	for file in ifl.file_names:
		_image_list.append(load(file))
		
	var tx = get_image(0)
	print(tx.resource_path)
	_shuffle_images()
	tx = get_image(0)
	print(tx.resource_path)
	pass


func get_random_item_image() -> void:
	return _image_list.pick_random()


func get_random_frame_image() -> Texture2D:
	return FRAME_IMAGES.pick_random()


func get_image(index: int) -> Texture2D:
	return _image_list[index]


func _shuffle_images() -> void:
	_image_list.shuffle()
