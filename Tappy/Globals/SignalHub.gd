extends Node


signal on_plane_died


func emit_on_plane_died() -> void:
	on_plane_died.emit()
