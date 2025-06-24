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


func _on_pressed() -> void:
	if Scorer.SelectionEnabled == true:
		reveal(true)
		SignalHub.emit_on_tile_selected(self)
