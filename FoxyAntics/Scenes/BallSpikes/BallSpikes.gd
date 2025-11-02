extends PathFollow2D


@export var speed: float = 50.0
@export var spin_speed: float = 360



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta
	rotation_degrees += spin_speed * delta
