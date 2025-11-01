extends Camera2D


@export var shake_amount: float = 5.0
@export var shake_time: float = 0.3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)


func _enter_tree() -> void:
	SignalHub.on_player_hit.connect(on_player_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	offset = Vector2(
		randf_range(-shake_amount, shake_amount),
		randf_range(-shake_amount, shake_amount)
	)

func reset_camera() -> void:
	set_process(false)
	offset = Vector2.ZERO



func on_player_hit(lives: int, shake: bool) -> void:
	if shake == true:
		set_process(true)
		await get_tree().create_timer(shake_time).timeout
		reset_camera()
