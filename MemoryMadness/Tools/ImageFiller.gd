@tool
extends EditorScript

const PATH: String = "res://assets/glitch/"
const RES_PATH: String = "res://Resources/image_files_list.tres" 



func _run() -> void: 
	var dir: DirAccess = DirAccess.open(PATH)
	var ifl: ImageFilesListResource = ImageFilesListResource.new()
	
	if dir:
		var files: PackedStringArray = dir.get_files()
		for fn in files:
			ifl.add_file(PATH + fn)
	ResourceSaver.save(ifl, RES_PATH)
