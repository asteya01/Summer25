# zombie.gd

extends CharacterBody2D


var damage_interval = 0.75
var damage_timer = 0
var direction = Vector2.ZERO
var direction_change_interval = 3
var direction_change_timer = 0
var health = 20
var is_dead = false
var player = null
var player_in_range = false
var speed = 50
var time_between_attacks = 0.5
var time_since_last_attacked = 0.0
var track_player = false
var min_position = Vector2(0, 0)
var max_position = Vector2(260, 140)


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Enemy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass  # Replace with function body.


# Called each physics frame with the time since the last physics frame as argument (delta, in seconds).
func _physics_process(delta):
	if player and player_in_range: # in range of the enemy hitbox
		# Deal damage from player
		time_since_last_attacked += delta
		if time_since_last_attacked >= time_between_attacks:
			if player.is_attacking:
				time_since_last_attacked = 0
				$AnimatedSprite2D.play("hurt_left")
				Global.play_sound("zombie/hurt1")
				if Global.selected_item.contains("shovel"):
					health -= 2
				elif Global.selected_item.contains("pickaxe"):
					health -= 3
				elif Global.selected_item.contains("axe"):
					health -= 4
				elif Global.selected_item.contains("sword"):
					health -= 5
				else:
					health -= 1
				die()
	elif player and track_player: # in the enemy's territory (agro range)
		# Move towards player
		var direction_to_player = (player.position - position).normalized()
		velocity = direction_to_player * speed
		update_animation(direction_to_player)
	else:
		# Move random direction
		direction_change_timer += delta
		if direction_change_timer >= direction_change_interval:
			pick_random_direction()
			direction_change_timer = 0
		velocity = direction * speed
		update_animation(direction)
	move_and_slide()
	# Keep this entity in-bounds
	var old_position = position
	position.x = clamp(position.x, min_position.x, max_position.x)
	position.y = clamp(position.y, min_position.y, max_position.y)
	# Attack player
	if player_in_range:
		damage_timer += delta
	if damage_timer >= damage_interval:
		if player:
			Global.player_health -= 3
			$AnimatedSprite2D.play("attack_left")
			Global.play_sound("zombie/step1")
		damage_timer = 0.0

func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true


func _on_hitbox_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false


func _on_territory_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		if Global.selected_item == "torch":
			player = null
			track_player = false
		else:
			track_player = true
			Global.play_sound("zombie/say1")


func _on_territory_body_exited(body):
	if body.is_in_group("Player"):
		player = null
		track_player = false
		pick_random_direction()


func die():
	if health <= 0 and not is_dead:
		Global.play_sound("zombie/death")
		queue_free()


func pick_random_direction():
	var rng = RandomNumberGenerator.new()
	var random_number = rng.randi_range(1, 4)
	if random_number == 1:
		direction = Vector2.DOWN
	elif random_number == 2:
		direction = Vector2.LEFT
	elif random_number == 3:
		direction = Vector2.RIGHT
	elif random_number == 4:
		direction = Vector2.UP


func update_animation(direction):
	if direction == Vector2.DOWN:
		pass
	elif direction == Vector2.LEFT:
		$AnimatedSprite2D.play("walk_left")
	elif direction == Vector2.RIGHT:
		$AnimatedSprite2D.play("walk_right")
	elif direction == Vector2.UP:
		pass
