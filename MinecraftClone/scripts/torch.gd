# torch.gd

extends Area2D


var player_in_range = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Hide if not day
	$PointLight2D.visible = not Global.day


# Called once for every event before _unhandled_input(), allowing you to consume some events.
func _input(event):
	if player_in_range:
		if event.is_action_pressed("Attack"):
			# Give player "torch"
			var item = {}
			item.id = "torch"
			item.stack_size = 1
			item.quantity = 1
			item.texture = "res://textures/torch.png"
			Global.add_item_to_inventory(item)
			queue_free()


func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true


func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false
