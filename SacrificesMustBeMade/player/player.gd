extends CharacterBody3D



func _unhandled_input(event):
	if event is InputEventMouseMotion: 
		rotation_degrees.y -= event.relative.x * 0.1
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.1
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -80.0, 80.0
		)
