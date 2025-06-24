extends Object


class_name LevelDataSelector


const LEVELS_DATA: LevelsDataResource = preload("res://Resources/levels_data.tres")

#region statics

static func get_level_setting(level: int) -> LevelSettingResource:
	return LEVELS_DATA.get_level_data(level)


static func get_level_selection(level_num: int) -> LevelDataSelector:
	var l_setting: LevelSettingResource = get_level_setting(level_num)
	
	if l_setting == null:
		return 
		
	ImageManager._shuffle_images()
	
	var selected_images: Array[Texture2D]
	
	for i in range(l_setting.get_target_pairs()):
		selected_images.append(ImageManager.get_image(i))
		selected_images.append(ImageManager.get_image(i))
		
	selected_images.shuffle()
	
	return LevelDataSelector.new(
		l_setting, selected_images
	)

#endregion

var _selected_images: Array[Texture2D]
var _level_setting: LevelSettingResource

func _init(level_setting: LevelSettingResource, 
					selected_images: Array[Texture2D]) -> void:
	_selected_images = selected_images
	_level_setting = level_setting


func get_selected_images() -> Array[Texture2D]:
	return _selected_images
	

func get_target_pairs() -> int:
	return _level_setting.get_target_pairs()


func get_num_cols() -> int:
	return _level_setting.get_cols()
