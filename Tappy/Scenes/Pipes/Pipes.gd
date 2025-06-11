extends Node2D


const SPEED: float = 120.0
const OFF_SCREEN: float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= SPEED * delta
	
	if position.x < get_viewport_rect().position.x - OFF_SCREEN:
		die()
		

func die() -> void:
	set_process(false)
	queue_free()

func _on_screen_exited() -> void:
	print("_on_screen_exited")
	die()
