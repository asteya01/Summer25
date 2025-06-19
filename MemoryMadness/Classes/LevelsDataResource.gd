extends Resource

class_name LevelsDataResource



@export var levels: Array[LevelSettingResource]


func get_level_count() -> int:
	return levels.size()


func get_level_data(level: int) -> LevelSettingResource:
	for ld in levels:
		if ld.get_level_number() == level: 
			return ld
	return null
