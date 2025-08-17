# global.gd

extends Node


var crops_grown_today = true
var day = true
var inventory = [null, null, null, null, null, null, null, null, null, null,
	null, null, null, null, null, null, null, null, null, null,
	null, null, null, null, null, null, null, null, null, null,
	null, null, null, null, null, null]
var is_falling = false
var is_raining = false
var last_direction = Vector2.RIGHT
var last_facing = Vector2.RIGHT
var mobs_spawned_today = true
var player_can_move = true
var player_health = 20
var rain_chance = 1/2
var rain_check_interval = 5
var rain_check_timer : Timer
var rain_duration = 60
var rain_timer = 0
var selected_item = ""
var time = 6
var time_cycle_duration = 300
var time_of_day = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	rain_check_timer = Timer.new()
	rain_check_timer.wait_time = Global.rain_check_interval
	rain_check_timer.autostart = true
	rain_check_timer.one_shot = false
	add_child(rain_check_timer)
	rain_check_timer.connect("timeout", Callable(self, "_on_RainCheckTimer_timeout"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate time_scale based on desired cycle duration
	var time_scale = 24.0 / time_cycle_duration
	Global.time += delta * time_scale
	# Reset after completing a cycle
	if Global.time >= 24.0:
		Global.time = 0.0
		Global.crops_grown_today = false
		Global.mobs_spawned_today = false
	# Update clock
	update_clock()
	Global.time_of_day = fmod(Global.time, 24.0)
	if Global.time_of_day >= 6.0 and Global.time_of_day < 18.0:
		Global.day = true
	else:
		Global.day = false
		if Global.mobs_spawned_today == false:
			# Create a [Zombie]
			var scene_instance = load("res://scenes/zombie.tscn")
			scene_instance = scene_instance.instantiate()
			scene_instance.global_transform.origin = Vector2(250, 50)
			# Add [Zombie] to scene
			var root_node = get_tree().get_root()
			root_node.add_child(scene_instance)
			Global.mobs_spawned_today = true
	# Reset rain timer after completing a cycle
	if Global.is_raining:
		Global.rain_timer += delta
		if Global.rain_timer >= Global.rain_duration:
			Global.is_raining = false
			Global.rain_timer = 0.0  # Reset the timer for the next rain event


# Handler for the rain check timer's timeout signal
func _on_RainCheckTimer_timeout():
	if not Global.is_raining and randf() < Global.rain_chance:
		# Not raining, so start the rain
		Global.is_raining = true
		Global.rain_timer = 0.0  # Reset rain timer


# Add item to player's inventory.
func add_item_to_inventory(item):
	# Add existing item
	if inventory_contains_item(item.id):
		change_item_quantity(item.id, 1)
	# Add new item
	else:
		var slot = get_first_empty_slot_number()
		item.slot = slot
		Global.inventory[slot] = item
		update_hud()


# Change the given item's quantity to the player's inventory.
func change_item_quantity(item_id, change = 0) -> int:
	for item in Global.inventory:
		if item != null:
			if item.has("id"):
				if item.id == item_id:
					item.quantity += change
					update_hud()
					return item.quantity
	return -1


# Get the first empty slot of the player's inventory.
func get_first_empty_slot_number():
	var index = -1
	for i in range(len(Global.inventory)):
		if Global.inventory[i] == null:
			return i
	return index


# Get the slot number of the given item in the player's inventory.
func get_inventory_slot_number(item_id) -> int:
	for item in Global.inventory:
		if item != null:
			if item.has("id"):
				if item.id == item_id:
					return item.slot
	return -1


# Check if the player's inventory contains the given item
func inventory_contains_item(item_id: String) -> bool:
	for item in Global.inventory:
		if item != null:
			if item.has("id"):
				if item.id == item_id:
					return true
	return false


# Plays the sound matching the given scene path.
func play_sound(sound):
	var tree = get_tree()
	var current_scene = tree.get_current_scene()
	var sounds = current_scene.get_node("sounds/" + sound)
	sounds.play()


# Remove item from player's inventory.
func remove_item_from_inventory(item_id):
	# Remove existing item
	if inventory_contains_item(item_id):
		var quantity = change_item_quantity(item_id, -1)
		# Clear slot if none left
		if quantity == 0:
			var item_slot = get_inventory_slot_number(item_id)
			Global.inventory[item_slot] = null
		update_hud()


# Hack to silence player so other effects can be played.
func stop_player_sound():
	stop_sound("player/strong1")
	stop_sound("player/strong2")
	stop_sound("player/strong3")
	stop_sound("player/strong4")
	stop_sound("player/strong5")
	stop_sound("player/strong6")


# Stops the sound matching the given scene path.
func stop_sound(sound):
	var tree = get_tree()
	var current_scene = tree.get_current_scene()
	var sounds = current_scene.get_node("sounds/" + sound)
	sounds.stop()


func update_clock():
	var tree = get_tree()
	var current_scene = tree.get_current_scene()
	var clock_texture = current_scene.get_node("TileMap/player/hud/Clock/TextureRect")
	if Global.time >= 0 and Global.time < 1:
		clock_texture.texture = load("res://textures/clock/clock_40.png")
	elif Global.time >= 1 and Global.time < 2:
		clock_texture.texture = load("res://textures/clock/clock_42.png")
	elif Global.time >= 2 and Global.time < 3:
		clock_texture.texture = load("res://textures/clock/clock_45.png")
	elif Global.time >= 3 and Global.time < 4:
		clock_texture.texture = load("res://textures/clock/clock_47.png")
	elif Global.time >= 4 and Global.time < 5:
		clock_texture.texture = load("res://textures/clock/clock_50.png")
	elif Global.time >= 5 and Global.time < 6:
		clock_texture.texture = load("res://textures/clock/clock_52.png")
	elif Global.time >= 6 and Global.time < 7:
		clock_texture.texture = load("res://textures/clock/clock_55.png")
	elif Global.time >= 7 and Global.time < 8:
		clock_texture.texture = load("res://textures/clock/clock_57.png")
	elif Global.time >= 8 and Global.time < 9:
		clock_texture.texture = load("res://textures/clock/clock_60.png")
	elif Global.time >= 9 and Global.time < 10:
		clock_texture.texture = load("res://textures/clock/clock_02.png")
	elif Global.time >= 10 and Global.time < 11:
		clock_texture.texture = load("res://textures/clock/clock_05.png")
	elif Global.time >= 11 and Global.time < 12:
		clock_texture.texture = load("res://textures/clock/clock_07.png")
	elif Global.time >= 12 and Global.time < 13:
		clock_texture.texture = load("res://textures/clock/clock_10.png")
	elif Global.time >= 13 and Global.time < 14:
		clock_texture.texture = load("res://textures/clock/clock_12.png")
	elif Global.time >= 14 and Global.time < 15:
		clock_texture.texture = load("res://textures/clock/clock_15.png")
	elif Global.time >= 15 and Global.time < 16:
		clock_texture.texture = load("res://textures/clock/clock_17.png")
	elif Global.time >= 16 and Global.time < 17:
		clock_texture.texture = load("res://textures/clock/clock_20.png")
	elif Global.time >= 17 and Global.time < 18:
		clock_texture.texture = load("res://textures/clock/clock_22.png")
	elif Global.time >= 18 and Global.time < 19:
		clock_texture.texture = load("res://textures/clock/clock_25.png")
	elif Global.time >= 19 and Global.time < 20:
		clock_texture.texture = load("res://textures/clock/clock_27.png")
	elif Global.time >= 20 and Global.time < 21:
		clock_texture.texture = load("res://textures/clock/clock_30.png")
	elif Global.time >= 21 and Global.time < 22:
		clock_texture.texture = load("res://textures/clock/clock_32.png")
	elif Global.time >= 22 and Global.time < 23:
		clock_texture.texture = load("res://textures/clock/clock_35.png")
	elif Global.time >= 23 and Global.time < 24:
		clock_texture.texture = load("res://textures/clock/clock_37.png")


# Update the HUD based on the player's status and inventory
func update_hud():
	var tree = get_tree()
	var current_scene = tree.get_current_scene()
	var hud = current_scene.get_node("TileMap/player/hud")
	hud.actionbar_slot_textures()
	hud.inventory_slot_textures()
