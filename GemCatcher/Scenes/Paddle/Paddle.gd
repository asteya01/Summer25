extends Area2D


const SPEED: float = 600.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement: float = Input.get_axis("move_left", "move_right")
	position.x += SPEED * delta * movement

	position.x = clampf(
		position.x,
		 Game.get_vpr().position.x,
		 Game.get_vpr().end.x
	)


func _on_area_entered(area: Area2D) -> void:
	print("_on_area_entered from Paddle Definition")
