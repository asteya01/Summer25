extends Node2D


@onready var label: Label = $CanvasLayer/Label
@onready var parallax_2d: Parallax2D = $Node2D/Parallax2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "%s" % [
		parallax_2d.screen_offset
	]
