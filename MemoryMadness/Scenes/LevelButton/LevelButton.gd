extends TextureButton


@export var level_number: int = 1


@onready var label: Label = $Label
@onready var sound: AudioStreamPlayer = $Sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ls: LevelSettingResource = \
	LevelDataSelector.get_level_setting(level_number)
	if ls == null:
		queue_free()
	else:
		label.text = "%dx%d" % [ls.get_cols(), ls.get_rows()]



func _on_pressed() -> void:
	SignalHub.emit_on_level_selected(level_number)
	SoundManager.play_button_click(sound)
