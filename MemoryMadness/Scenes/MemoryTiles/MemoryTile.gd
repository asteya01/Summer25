extends TextureButton


class_name MemoryTile


@onready var frame_image: TextureRect = $FrameImage
@onready var item_image: TextureRect = $ItemImage


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reveal(false)
	

func reveal(r: bool) -> void:
	frame_image.visible = r
	item_image.visible = r


func setup(image: Texture2D, frame: Texture2D) -> void:
	frame_image.texture = frame
	item_image.texture = image


func matches_other_tile(other: MemoryTile) -> bool:
	return other != self \
			and other.item_image.texture == item_image.texture


func kill_on_success() -> void:
	z_index = 1
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "disabled", true, 0)
	tween.tween_property(self, "rotation_degrees", 720, 0.5)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.5)
	tween.set_parallel(false)
	tween.tween_interval(0.6)
	tween.tween_property(self, "scale", Vector2.ZERO, 00)



func _on_pressed() -> void:
	if Scorer.SelectionEnabled == true:
		reveal(true)
		SignalHub.emit_on_tile_selected(self)
