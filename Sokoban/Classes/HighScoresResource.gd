extends Resource


class_name HighScoresResource


const SCORE_FILE: String = "user://sokoban_scores.tres"
const DEFAULT_SCORE: int = 999999


@export var high_scores: Dictionary[String, int]


func add_score(level: String, score: int) -> bool:
	var was_best: bool = false
	var current_best = high_scores.get(level, DEFAULT_SCORE)  
	if current_best > score:
		high_scores[level] = score
		was_best = true
	ResourceSaver.save(self, SCORE_FILE)
	return was_best


func get_best_score(level: String) -> int:
	return DEFAULT_SCORE if !high_scores.has(level) else high_scores[level]
	
	
func has_level_score(level: String) -> bool:
	return high_scores.has(level)


static func load_scores() -> HighScoresResource:
	if ResourceLoader.exists(SCORE_FILE):
		return load(SCORE_FILE)
	return HighScoresResource.new()
	
