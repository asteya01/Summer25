extends Camera2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		position.x -= 600 * delta
	if Input.is_action_pressed("right"):
		position.x += 600 * delta
	if Input.is_action_pressed("up"):
		position.y -= 600 * delta
	if Input.is_action_pressed("down"):
		position.y += 600 * delta
