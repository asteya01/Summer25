extends Label

func _ready():
	# Wait one frame to ensure the UI layout has been calculated and the size is correct.
	await get_tree().process_frame

	# Set the pivot point to the center of the label's size.
	# The property was renamed from rect_pivot_offset to pivot_offset.
	pivot_offset = size / 2

	# Rotate the label 10 degrees clockwise for a "down diagonal" effect.
	rotation_degrees = 0
	rotation_degrees = 10
