extends Resource

class_name LevelScoresResource


const DEFAULT_SCORE: int = 1000


@export var level_scores: Dictionary[String, int]


func get_level_best(level: String) -> int:
	return level_scores.get(level, DEFAULT_SCORE)
	

func update_level_score(level: String, score: int) -> void:
	var best: int = get_level_best(level)
	if best > score:
		level_scores[level] = score
		
		
func level_exists(level: String) -> bool:
	return level in level_scores
