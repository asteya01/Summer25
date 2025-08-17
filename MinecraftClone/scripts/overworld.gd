# overworld.gd

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass  # Replace with function body.


# Called each physics frame with the time since the last physics frame as argument (delta, in seconds).
func _physics_process(delta):
	# Check if player has fallen into the void
	var tilemap = $TileMap
	var source_id_layer_0 = tilemap.get_cell_source_id(0, get_map_position()) # Bedrock Layer
	var source_id_layer_1 = tilemap.get_cell_source_id(1, get_map_position()) # Base Layer
	var source_id_layer_2 = tilemap.get_cell_source_id(2, get_map_position()) # Breakable Layer
	if (source_id_layer_0 == -1
	and source_id_layer_1 == -1
	and source_id_layer_2 == -1):
		Global.is_falling = true
	else:
		Global.is_falling = false
	# Grow crops each day
	if Global.crops_grown_today == false:
		grow_crops()

# Called once for every event before _unhandled_input(), allowing you to consume some events.
func _input(event):
	
	# If the inventory is currently visible
	var slots_visible = $TileMap/player/hud/Slots.visible
	
	# 🅑 "Use"
	if event.is_action_pressed("Use") and slots_visible == false:

		# Get cell at "Base Layer" of TileMap
		var source_id = $TileMap.get_cell_source_id(1, get_map_position())

		# Use "chest" to place "chest"
		if Global.selected_item == "chest":
			Global.play_sound("player/step/wood1")
			set_cell(2, 12) 						# Source ID 12: "cobblestone"
			Global.remove_item_from_inventory("chest")
		
		# Use "crafting_table" to place "crafting_table"
		if Global.selected_item == "crafting_table":
			Global.play_sound("player/step/wood1")
			set_cell(2, 19) 						# Source ID 19: "crafting_table"
			Global.remove_item_from_inventory("crafting_table")
		
		# Use "cobblestone" to place "cobblestone"
		if Global.selected_item == "cobblestone":
			Global.play_sound("player/step/stone1")
			set_cell(2, 0) 						# Source ID 0: "cobblestone"
			Global.remove_item_from_inventory("cobblestone")
		
		# Use "log_oak" to place "log_oak"
		if Global.selected_item == "log_oak":
			Global.play_sound("player/step/wood1")
			set_cell(2, 5) 						# Source ID 5: "log_oak"
			Global.remove_item_from_inventory("log_oak")
		
		# Use "log_oak_top" to place "log_oak_top"
		if Global.selected_item == "log_oak_top":
			Global.play_sound("player/step/wood1")
			set_cell(2, 6) 						# Source ID 6: "log_oak_top"
			Global.remove_item_from_inventory("log_oak_top")
		
		# Use "planks_oak" to place "planks_oak"
		if Global.selected_item == "planks_oak":
			Global.play_sound("player/step/wood1")
			set_cell(2, 7) 						# Source ID 7: "planks_oak"
			Global.remove_item_from_inventory("planks_oak")
		
		# Use "poppy" to place "poppy"
		if Global.selected_item == "poppy":
			Global.play_sound("player/step/grass1")
			set_cell(2, 16) 					# Source ID 16: "poppy"
			Global.remove_item_from_inventory("poppy")
		
		# Use "sapling_oak" on grass/path/farmland to plant "sapling_oak"
		if Global.selected_item == "sapling_oak":
			if(source_id == 2 					# Source ID 2: "grass",
			or source_id == 8 					# Source ID 8: "grass_path"
			or source_id == 20 					# Source ID 20: "farmland_wet"
			or source_id == 21): 				# Source ID 21: "farmland_dry"
				Global.play_sound("player/step/grass1")
				set_cell(2, 9) 					# Source ID 9: "sappling_oak"
				Global.remove_item_from_inventory("sapling_oak")
		
		# Use "seeds_wheat" on "farmland_(dry/wet)" to plant "wheat"
		if Global.selected_item == "seeds_wheat":
			if(source_id == 20 					# Source ID 20: "farmland_wet"
			or source_id == 21): 				# Source ID 21: "farmland_dry"
				Global.play_sound("player/step/grass1")
				set_cell(2, 22) 				# Source ID 22: "wheat"
				Global.remove_item_from_inventory("seeds_wheat")
		
		# Use "torch" to place "torch"
		if Global.selected_item == "torch":
			Global.play_sound("player/step/wood1")
			# Create a [Torch]
			var scene_instance = load("res://scenes/torch.tscn")
			scene_instance = scene_instance.instantiate()
			var player_position = $TileMap/player.position
			scene_instance.global_transform.origin = player_position + Vector2(16, 16)
			# Add [Torch] to scene
			var root_node = get_tree().get_root()
			root_node.add_child(scene_instance)
			Global.remove_item_from_inventory("torch")
		
		# Use "wood_hoe" to make "farmland_dry"
		if Global.selected_item == "wood_hoe":
			if (source_id == 2 					# Source ID 2: "grass"
			or source_id == 8): 				# Source ID 8: "grass_path"
				Global.play_sound("player/dig/grass1")
				set_cell(1, 21) 				# Source ID 21: "farmland_dry"
		
		# Use "wood_shovel" to make "grass_path"
		if Global.selected_item == "wood_shovel":
			if(source_id == 2 					# Source ID 2: "grass"
			or source_id == 21): 				# Source ID 21: "farmland_dry"
				Global.play_sound("player/step/grass1")
				set_cell(1, 8) 					# Source ID 8: "grass_path"
		
		# Check "Breakable Layer" for a "chest"
		if Global.last_direction == Vector2.RIGHT:
			var tile_to_right = get_map_position(Vector2(16,0))
			var right_source_id = $TileMap.get_cell_source_id(2, tile_to_right)
			if (right_source_id == 12): 			# Source ID 12: "chest"
				$TileMap/player/hud.chest_ui_show()
		elif Global.last_direction == Vector2.LEFT:
			var tile_to_left = get_map_position(Vector2(-16,0))
			var left_source_id = $TileMap.get_cell_source_id(2, tile_to_left)
			if (left_source_id == 12): 			# Source ID 12: "chest"
				$TileMap/player/hud.chest_ui_show()
		else:
			var tile_to_up = get_map_position(Vector2(0,0))
			var up_source_id = $TileMap.get_cell_source_id(2, tile_to_up)
			if (up_source_id == 12): 			# Source ID 12: "chest"
				$TileMap/player/hud.chest_ui_show()
		
		# Check "Breakable Layer" for a "crafting_table"
		if Global.last_direction == Vector2.RIGHT:
			var tile_to_right = get_map_position(Vector2(16,0))
			var right_source_id = $TileMap.get_cell_source_id(2, tile_to_right)
			if (right_source_id == 19): 			# Source ID 19: "crafting_table"
				$TileMap/player/hud.crafting_table_ui_show()
		elif Global.last_direction == Vector2.LEFT:
			var tile_to_left = get_map_position(Vector2(-16,0))
			var left_source_id = $TileMap.get_cell_source_id(2, tile_to_left)
			if (left_source_id == 19): 			# Source ID 19: "crafting_table"
				$TileMap/player/hud.crafting_table_ui_show()
		else:
			var tile_to_up = get_map_position(Vector2(0,0))
			var up_source_id = $TileMap.get_cell_source_id(2, tile_to_up)
			if (up_source_id == 19): 			# Source ID 19: "crafting_table"
				$TileMap/player/hud.crafting_table_ui_show()

	# 🅐 "Attack"
	if event.is_action_pressed("Attack") and slots_visible == false:
		
		# Get cell at "Breakable Layer" of TileMap
		var source_id = $TileMap.get_cell_source_id(2, get_map_position())
		
		# Pick up "(double/tall)_grass" and add "seeds_wheat" to inventory
		if (source_id == 10						# Source ID : "double_grass"
		or source_id == 11):					# Source ID : "tall_grass"
			Global.stop_player_sound()
			Global.play_sound("random/pop")
			$TileMap.erase_cell(2, get_map_position())
			give_item("seeds_wheat", 64)
		
		# Pick up "sappling_oak" and add to inventory
		if source_id == 9: 						# Source ID 9: "sappling_oak"
			Global.stop_player_sound()
			Global.play_sound("random/pop")
			$TileMap.erase_cell(2, get_map_position())
			give_item("sapling_oak", 64)
		
		# Pick up "wheat_7" and add "wheat" to inventory
		if source_id == 23: 					# Source ID 23: "wheat_7"
			Global.stop_player_sound()
			Global.play_sound("random/pop")
			$TileMap.erase_cell(2, get_map_position())
			give_item("wheat", 1)
		
		# Pick up "poppy" and add to inventory
		if source_id == 16: 					# Source ID 16: "poppy"
			Global.stop_player_sound()
			Global.play_sound("random/pop")
			$TileMap.erase_cell(2, get_map_position())
			give_item("poppy", 1)
		
		# Use "wood_axe" to cut "log_oak", "log_oak_top", and "planks_oak"
		if Global.selected_item == "wood_axe":
			# Check to the right, if facing right
			if Global.last_direction == Vector2.RIGHT:
				var tile_to_right = get_map_position(Vector2(16,0))
				var right_source_id = $TileMap.get_cell_source_id(2, tile_to_right)
				if (right_source_id == 5): 		# Source ID 5: "log_oak"
					Global.stop_player_sound()
					Global.play_sound("player/dig/wood1")
					$TileMap.erase_cell(2, tile_to_right)
					give_item("log_oak", 64)
				elif (right_source_id == 6): 	# Source ID 6: "log_oak_top"
					Global.stop_player_sound()
					Global.play_sound("player/dig/wood1")
					$TileMap.erase_cell(2, tile_to_right)
					give_item("log_oak_top", 64)
				elif (right_source_id == 7): 	# Source ID 7: "planks_oak"
					Global.stop_player_sound()
					Global.play_sound("player/dig/wood1")
					$TileMap.erase_cell(2, tile_to_right)
					give_item("planks_oak", 64)
				elif (right_source_id == 12):	# Source ID 12: "chest"
					Global.stop_player_sound()
					Global.play_sound("player/dig/wood1")
					$TileMap.erase_cell(2, tile_to_right)
					give_item("chest", 1)
				elif (right_source_id == 19):	# Source ID 19: "crafting_table"
					Global.stop_player_sound()
					Global.play_sound("player/dig/wood1")
					$TileMap.erase_cell(2, tile_to_right)
					give_item("crafting_table", 1)
			# Check to the left, if facing left
			else:
				var tile_to_left = get_map_position(Vector2(-16,0))
				var left_source_id = $TileMap.get_cell_source_id(2, tile_to_left)
				if (left_source_id == 5): 		# Source ID 5: "log_oak"
					Global.stop_player_sound()
					Global.play_sound("player/dig/wood1")
					$TileMap.erase_cell(2, tile_to_left)
					give_item("log_oak", 64)
				elif (left_source_id == 6): 	# Source ID 6: "log_oak_top"
					Global.stop_player_sound()
					Global.play_sound("player/dig/wood1")
					$TileMap.erase_cell(2, tile_to_left)
					give_item("log_oak_top", 64)
				elif (left_source_id == 7): 	# Source ID 7: "planks_oak"
					Global.stop_player_sound()
					Global.play_sound("player/dig/wood1")
					$TileMap.erase_cell(2, tile_to_left)
					give_item("planks_oak", 64)
				elif (left_source_id == 12):	# Source ID 12: "chest"
					Global.stop_player_sound()
					Global.play_sound("player/dig/wood1")
					$TileMap.erase_cell(2, tile_to_left)
					give_item("chest", 1)
				elif (left_source_id == 19):	# Source ID 19: "crafting_table"
					Global.stop_player_sound()
					Global.play_sound("player/dig/wood1")
					$TileMap.erase_cell(2, tile_to_left)
					give_item("crafting_table", 1)
		
		# Use "wood_pickaxe" to mine "cobblestone" and "stone"
		if Global.selected_item == "wood_pickaxe":
			# Check to the right, if facing right
			if Global.last_direction == Vector2.RIGHT:
				var tile_to_right = get_map_position(Vector2(16,0))
				var right_source_id = $TileMap.get_cell_source_id(2, tile_to_right)
				if (right_source_id == 0 		# Source ID 0: "cobblestone"
				or right_source_id == 18): 		# Source ID 18: "stone"
					Global.stop_player_sound()
					Global.play_sound("player/dig/stone1")
					$TileMap.erase_cell(2, tile_to_right)
					give_item("cobblestone", 64)
			# Check to the left, if facing left
			else:
				var tile_to_left = get_map_position(Vector2(-16,0))
				var left_source_id = $TileMap.get_cell_source_id(2, tile_to_left)
				if (left_source_id == 0 		# Source ID 0: "cobblestone"
				or left_source_id == 18): 		# Source ID 18: "stone"
					Global.stop_player_sound()
					Global.play_sound("player/dig/stone1")
					$TileMap.erase_cell(2, tile_to_left)
					give_item("cobblestone", 64)
		
		# Check "Leaf Layer" for "leaves_oak"
		if Global.last_direction == Vector2.RIGHT:
			var tile_to_right = get_map_position(Vector2(16,0))
			var right_source_id = $TileMap.get_cell_source_id(3, tile_to_right)
			if (right_source_id == 15): 			# Source ID 15: "leaves_oak"
				Global.stop_player_sound()
				Global.play_sound("player/dig/stone1")
				$TileMap.erase_cell(3, tile_to_right)
				give_item("leaves_oak", 64)
		else:
			var tile_to_left = get_map_position(Vector2(-16,0))
			var left_source_id = $TileMap.get_cell_source_id(3, tile_to_left)
			if (left_source_id == 15): 			# Source ID 15: "leaves_oak"
				Global.stop_player_sound()
				Global.play_sound("player/dig/stone1")
				$TileMap.erase_cell(3, tile_to_left)
				give_item("leaves_oak", 64)


# Gets the player's current map position.
func get_map_position(offset=Vector2(0,0)):
	var player = $TileMap/player
	var tilemap = $TileMap
	var player_position = player.position + offset
	var map_position = tilemap.local_to_map(player_position)
	return map_position


# Adds the item to the player's inventory.
func give_item(item_name, stack_size = 1):
	var item = {}
	item.id = item_name
	item.stack_size = stack_size
	item.quantity = 1
	item.texture = "res://textures/" + item_name + ".png"
	Global.add_item_to_inventory(item) 


# Looks for and ages crops around the player.
func grow_crops():

	# Get the TileMap
	var tilemap = $TileMap

	# Define the range of points
	var start = -256
	var end = 256
	
	# Define the grid size
	var grid_size = 32
	
	# Calculate the step size for each point
	var step = (end - start) / (grid_size-1)

	# Iterate over each point
	for i in range(grid_size):
		for j in range(grid_size):
			# Calculate the coordinates for the current point
			var x = start + i * step
			var y = start + j * step
			# Get Tile Map data at the coordinates of the current point
			var source_id = tilemap.get_cell_source_id(1, get_map_position(Vector2(x, y)))
			# Handle Farmland
			if (source_id == 20					# Source ID 20: "farmland_wet"
			or source_id == 21):				# Source ID 21: "farmland_dry"
				# Check for crops
				var source_id_layer_2 = tilemap.get_cell_source_id(2, get_map_position(Vector2(x, y)))
				# Handle "wheat_0" -> "wheat_6"
				if source_id_layer_2 == 22: 	# Source ID 22: "wheat_0"
					$TileMap.set_cell(2, get_map_position(Vector2(x, y)), 26, Vector2i(0, 0), 0)
				elif source_id_layer_2 == 26: 	# Source ID 26: "wheat_1"
					$TileMap.set_cell(2, get_map_position(Vector2(x, y)), 27, Vector2i(0, 0), 0)
				elif source_id_layer_2 == 27: 	# Source ID 27: "wheat_2"
					$TileMap.set_cell(2, get_map_position(Vector2(x, y)), 28, Vector2i(0, 0), 0)
				elif source_id_layer_2 == 28: 	# Source ID 28: "wheat_3"
					$TileMap.set_cell(2, get_map_position(Vector2(x, y)), 29, Vector2i(0, 0), 0)
				elif source_id_layer_2 == 29: 	# Source ID 29: "wheat_4"
					$TileMap.set_cell(2, get_map_position(Vector2(x, y)), 30, Vector2i(0, 0), 0)
				elif source_id_layer_2 == 30: 	# Source ID 30: "wheat_5"
					$TileMap.set_cell(2, get_map_position(Vector2(x, y)), 31, Vector2i(0, 0), 0)
				elif source_id_layer_2 == 31: 	# Source ID 31: "wheat_6"
					$TileMap.set_cell(2, get_map_position(Vector2(x, y)), 23, Vector2i(0, 0), 0)
	
	# Set global flag so this only happens once per day
	Global.crops_grown_today = true


# Set the tile at the player's position.
func set_cell(layer, source_id):
	var map_position = get_map_position()
	$TileMap.set_cell(layer, map_position, source_id, Vector2i(0, 0), 0)
