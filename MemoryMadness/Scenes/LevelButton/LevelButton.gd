extends TextureButton


@export var level_number: int = 1


@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ls: LevelSettingResource = \
	LevelDataSelector.get_level_setting(level_number)
	if ls == null:
		queue_free()
	else:
		label.text = "%dx%d" % [ls.get_cols(), ls.get_rows()]



func _on_pressed() -> void:
	pass # Replace with function body.
