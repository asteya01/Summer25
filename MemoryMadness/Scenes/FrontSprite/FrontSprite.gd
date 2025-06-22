extends TextureRect


const SCALE_SMALL: Vector2 = Vector2(0.1, 0.1)
const SCALE_NORMAL: Vector2 = Vector2(1.0, 1.0)
const SCALE_TIME: float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_random_image()
	run_me()


func set_random_image() -> void:
	texture = ImageManager.get_random_item_image()
	
	
func get_random_spin_time() -> float:
	return randf_range(1.0, 2.0)


func get_random_rotation() -> float:
	return deg_to_rad(randf_range(-360, 360))


func run_me() -> void:
	var tween: Tween = create_tween()
	#tween.set_loops()
	tween.tween_property(self, "scale", SCALE_SMALL, SCALE_TIME)
	tween.tween_callback(set_random_image)
	tween.tween_property(self, "scale", SCALE_NORMAL, SCALE_TIME)
	tween.tween_property(self, "rotation", 
			get_random_rotation(), get_random_spin_time())
	tween.tween_callback(run_me)
