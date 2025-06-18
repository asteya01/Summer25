extends Resource


class_name ImageFilesListResource


@export var file_names: Array[String]


func add_file(fn: String) -> void:
	if fn.ends_with(".import") == false:
		file_names.append(fn)
