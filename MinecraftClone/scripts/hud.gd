# hud.gd

extends CanvasLayer


var actionbar_selected_slot = 1
var highlighted_slot = 0
var selected_slot = 0

@onready var action_bar_quantity_labels = [$ActionBar/Quantity1, $ActionBar/Quantity2, $ActionBar/Quantity3, $ActionBar/Quantity4,
	$ActionBar/Quantity5, $ActionBar/Quantity6, $ActionBar/Quantity7, $ActionBar/Quantity8, $ActionBar/Quantity9
]
@onready var action_bar_slot_images = [$ActionBar/Slot1/SlotTexture, $ActionBar/Slot2/SlotTexture, $ActionBar/Slot3/SlotTexture, $ActionBar/Slot4/SlotTexture,
	$ActionBar/Slot5/SlotTexture, $ActionBar/Slot6/SlotTexture, $ActionBar/Slot7/SlotTexture, $ActionBar/Slot8/SlotTexture, $ActionBar/Slot9/SlotTexture
]
@onready var inventory_slot_quantity_labels = [$Slots/Quantity1, $Slots/Quantity2, $Slots/Quantity3, $Slots/Quantity4,
	$Slots/Quantity5, $Slots/Quantity6, $Slots/Quantity7, $Slots/Quantity8, $Slots/Quantity9,
	$Slots/Quantity10, $Slots/Quantity11, $Slots/Quantity12, $Slots/Quantity13, $Slots/Quantity14,
	$Slots/Quantity15, $Slots/Quantity16, $Slots/Quantity17, $Slots/Quantity18, $Slots/Quantity19,
	$Slots/Quantity20, $Slots/Quantity21, $Slots/Quantity22, $Slots/Quantity23, $Slots/Quantity24,
	$Slots/Quantity25, $Slots/Quantity26, $Slots/Quantity27, $Slots/Quantity28, $Slots/Quantity29,
	$Slots/Quantity30, $Slots/Quantity31, $Slots/Quantity32, $Slots/Quantity33, $Slots/Quantity34,
	$Slots/Quantity35, $Slots/Quantity36
]
@onready var inventory_slot_images = [$Slots/Slot1/SlotTexture, $Slots/Slot2/SlotTexture, $Slots/Slot3/SlotTexture, $Slots/Slot4/SlotTexture,
	$Slots/Slot5/SlotTexture, $Slots/Slot6/SlotTexture, $Slots/Slot7/SlotTexture, $Slots/Slot8/SlotTexture, $Slots/Slot9/SlotTexture,
	$Slots/Slot10/SlotTexture, $Slots/Slot11/SlotTexture, $Slots/Slot12/SlotTexture, $Slots/Slot13/SlotTexture, $Slots/Slot14/SlotTexture,
	$Slots/Slot15/SlotTexture, $Slots/Slot16/SlotTexture, $Slots/Slot17/SlotTexture, $Slots/Slot18/SlotTexture, $Slots/Slot19/SlotTexture,
	$Slots/Slot20/SlotTexture, $Slots/Slot21/SlotTexture, $Slots/Slot22/SlotTexture, $Slots/Slot23/SlotTexture, $Slots/Slot24/SlotTexture,
	$Slots/Slot25/SlotTexture, $Slots/Slot26/SlotTexture, $Slots/Slot27/SlotTexture, $Slots/Slot28/SlotTexture, $Slots/Slot29/SlotTexture,
	$Slots/Slot30/SlotTexture, $Slots/Slot31/SlotTexture, $Slots/Slot32/SlotTexture, $Slots/Slot33/SlotTexture, $Slots/Slot34/SlotTexture,
	$Slots/Slot35/SlotTexture, $Slots/Slot36/SlotTexture
]


# Called when the node enters the scene tree for the first time.
func _ready():
	# Always show the HUD when paused
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Replace with function body.


# Called once for every event before _unhandled_input(), allowing you to consume some events.
func _input(event):
	
	# Display controls based on input type
	if event is InputEventScreenTouch: # 📱
		$DPad.visible = true;
		$NES.visible = true;
		$SNES.visible = false;
		$WASD.visible = false;
	elif event is InputEventJoypadMotion or event is InputEventJoypadButton: # 🎮
		$DPad.visible = true;
		$NES.visible = true;
		$SNES.visible = false;
		$WASD.visible = false;
	elif event is InputEventKey: # ⌨
		$DPad.visible = false;
		$NES.visible = false;
		$SNES.visible = false;
		$WASD.visible = true;
	
	# ˅ "Down" button released
	if event.is_action_released("ui_down"):
		$DPad/Base.visible = true
		$DPad/Down.visible = false
	# ˅ "Down" button pressed
	if event.is_action_pressed("ui_down"):
		$DPad/Base.visible = false
		$DPad/Down.visible = true
	# ˂ "Left" button released
	if event.is_action_released("ui_left"):
		$DPad/Base.visible = true
		$DPad/Left.visible = false
	# ˂ "Left" button pressed
	if event.is_action_pressed("ui_left"):
		$DPad/Base.visible = false
		$DPad/Left.visible = true
	# ˃ "Right" button released
	if event.is_action_released("ui_right"):
		$DPad/Base.visible = true
		$DPad/Right.visible = false
	# ˃ "Right" button pressed
	if event.is_action_pressed("ui_right"):
		$DPad/Base.visible = false
		$DPad/Right.visible = true
	# ˄ "Up" button released
	if event.is_action_released("ui_up"):
		$DPad/Base.visible = true
		$DPad/Up.visible = false
	# ˄ "Up" button pressed
	if event.is_action_pressed("ui_up"):
		$DPad/Base.visible = false
		$DPad/Up.visible = true
	# [Select] button pressed
	if event.is_action_pressed("Slot_Up"):
		$NES/ButtonSelect/Pressed.visible = true
	# [Select] button released
	if event.is_action_released("Slot_Up"):
		$NES/ButtonSelect/Pressed.visible = false
	# [Start] button pressed
	if event.is_action_pressed("Inventory"):
		$NES/ButtonStart/Pressed.visible = true
	# [Start] button released
	if event.is_action_released("Inventory"):
		$NES/ButtonStart/Pressed.visible = false
	# Ⓐ "Attack" button released
	if event.is_action_released("Attack"):
		$NES/ButtonA/Pressed.visible = false
	# 🅐 "Attack" button pressed
	if event.is_action_pressed("Attack"):
		$NES/ButtonA/Pressed.visible = true
	# Ⓑ "Use" button released
	if event.is_action_released("Use"):
		$NES/ButtonB/Pressed.visible = false
	# 🅑 "Use" button pressed
	if event.is_action_pressed("Use"):
		$NES/ButtonB/Pressed.visible = true
	
	# Inventory - Chest, hide
	if $SingleChest.visible:
		if event.is_action_pressed("ui_cancel"):
			Global.play_sound("chest/chestclosed")
			chest_ui_hide()
	
	# Inventory - Crafting Table, hide
	if $CraftingTable.visible:
		if event.is_action_pressed("ui_cancel"):
			crafting_table_ui_hide()
	
	# Inventory - Player, hide
	if $Inventory.visible:
		if (event.is_action_pressed("Inventory")
		or event.is_action_pressed("ui_cancel")):
			inventory_ui_hide()
	else:
		# Inventory - Player, show
		if event.is_action_pressed("Inventory"):
			chest_ui_hide()
			crafting_table_ui_hide()
			inventory_ui_show()
	
	# Inventroy Slot Navigation
	if $Slots.visible:
		# Navigate
		$NES/ButtonA/LabelAttack.visible = false
		$NES/ButtonA/LabelSelect.visible = true
		$NES/ButtonB/LabelUse.visible = false
		$NES/ButtonB/LabelCancel.visible = true
		# ˅ "Down" button pressed
		if event.is_action_pressed("ui_down"):
			if highlighted_slot >= 28:
				highlighted_slot -= 27
			elif highlighted_slot >= 1:
				highlighted_slot += 9
		# ˂ "Left" button pressed
		if event.is_action_pressed("ui_left"):
			if (highlighted_slot == 1
			or highlighted_slot == 10
			or highlighted_slot == 19
			or highlighted_slot == 28):
				highlighted_slot += 8
			else:
				highlighted_slot -= 1
		# ˃ "Right" button pressed
		if event.is_action_pressed("ui_right"):
			if (highlighted_slot == 9
			or highlighted_slot == 18
			or highlighted_slot == 27
			or highlighted_slot == 36):
				highlighted_slot -= 8
			else:
				highlighted_slot += 1
		# ˄ "Up" button pressed
		if event.is_action_pressed("ui_up"):
			if highlighted_slot < 10:
				highlighted_slot += 27
			else:
				highlighted_slot -= 9
		# Ensure the slot number is within range
		highlighted_slot = clamp(highlighted_slot, 1, 36)
		# Ⓐ "Select" button pressed
		if event.is_action_pressed("Attack"):
			if selected_slot == 0:
				var node_path = "Slots/Slot" + str(highlighted_slot) + "/SlotSelected"
				var node = get_node(node_path)
				node.visible = true
				selected_slot = highlighted_slot
			else:
				inventory_swap_slots()
		# 🅑 "Cancel" button pressed
		elif event.is_action_pressed("Use"):
			if selected_slot > 0:
				var node_path = "Slots/Slot" + str(selected_slot) + "/SlotSelected"
				var node = get_node(node_path)
				node.visible = false
				selected_slot = 0
		# Highlight inventory active slot
		inventory_clear_slot_highlight()
		inventory_show_highlight()
	else:
		$NES/ButtonA/LabelAttack.visible = true
		$NES/ButtonA/LabelSelect.visible = false
		$NES/ButtonB/LabelUse.visible = true
		$NES/ButtonB/LabelCancel.visible = false
		# Highlight ActionBar selected slot
		actionbar_clear_slot_selection()
		actionbar_determine_slot_selection(event)
		actionbar_show_slot_selection()
		highlighted_slot = actionbar_selected_slot
		inventory_clear_slot_selection()


# Clears the selected slot frame for all slots on the ActionBar.
func actionbar_clear_slot_selection():
	for i in range(1, 10):
		var node_path = "ActionBar/Slot" + str(i)+ "/SlotSelected"
		var node = get_node(node_path)
		node.visible = false


# Determines the selected slot on the ActionBar.
func actionbar_determine_slot_selection(event):
	if event.is_action_pressed("Slot_1"):
		actionbar_selected_slot = 1
	elif event.is_action_pressed("Slot_2"):
		actionbar_selected_slot = 2
	elif event.is_action_pressed("Slot_3"):
		actionbar_selected_slot = 3
	elif event.is_action_pressed("Slot_4"):
		actionbar_selected_slot = 4
	elif event.is_action_pressed("Slot_5"):
		actionbar_selected_slot = 5
	elif event.is_action_pressed("Slot_6"):
		actionbar_selected_slot = 6
	elif event.is_action_pressed("Slot_7"):
		actionbar_selected_slot = 7
	elif event.is_action_pressed("Slot_8"):
		actionbar_selected_slot = 8
	elif event.is_action_pressed("Slot_9"):
		actionbar_selected_slot = 9
	elif event.is_action_pressed("Slot_Down"):
		actionbar_selected_slot -= 1
		if actionbar_selected_slot < 1:
			actionbar_selected_slot = actionbar_selected_slot + 9
	elif event.is_action_pressed("Slot_Up"):
		actionbar_selected_slot += 1
		if actionbar_selected_slot > 9:
			actionbar_selected_slot = actionbar_selected_slot - 9


# Shows a frame on the selected slot on the ActionBar.
func actionbar_show_slot_selection():
	if actionbar_selected_slot == 1:
		$ActionBar/Slot1/SlotSelected.visible = true
		actionbar_set_selected_item($ActionBar/Slot1/SlotTexture)
	elif actionbar_selected_slot == 2:
		$ActionBar/Slot2/SlotSelected.visible = true
		actionbar_set_selected_item($ActionBar/Slot2/SlotTexture)
	elif actionbar_selected_slot == 3:
		$ActionBar/Slot3/SlotSelected.visible = true
		actionbar_set_selected_item($ActionBar/Slot3/SlotTexture)
	elif actionbar_selected_slot == 4:
		$ActionBar/Slot4/SlotSelected.visible = true
		actionbar_set_selected_item($ActionBar/Slot4/SlotTexture)
	elif actionbar_selected_slot == 5:
		$ActionBar/Slot5/SlotSelected.visible = true
		actionbar_set_selected_item($ActionBar/Slot5/SlotTexture)
	elif actionbar_selected_slot == 6:
		$ActionBar/Slot6/SlotSelected.visible = true
		actionbar_set_selected_item($ActionBar/Slot6/SlotTexture)
	elif actionbar_selected_slot == 7:
		$ActionBar/Slot7/SlotSelected.visible = true
		actionbar_set_selected_item($ActionBar/Slot7/SlotTexture)
	elif actionbar_selected_slot == 8:
		$ActionBar/Slot8/SlotSelected.visible = true
		actionbar_set_selected_item($ActionBar/Slot8/SlotTexture)
	elif actionbar_selected_slot == 9:
		$ActionBar/Slot9/SlotSelected.visible = true
		actionbar_set_selected_item($ActionBar/Slot9/SlotTexture)


# Sets a global for the item in the selected slot on the ActionBar. The item texture file name must match the item name.
func actionbar_set_selected_item(texture_rect):
	var texture = texture_rect.texture
	if texture:
		var resource_path = texture.resource_path
		resource_path = resource_path.replace("res://textures/", "")
		resource_path = resource_path.replace(".png", "")
		Global.selected_item = resource_path
	else:
		Global.selected_item = ""


# Sets the textures for each slot in the ActionBar.
func actionbar_slot_textures():
	var inventory = Global.inventory
	inventory = inventory.slice(0,9)
	for i in range(len(inventory)):
		if inventory[i] != null:
			action_bar_quantity_labels[i].text = str(inventory[i].quantity)
			action_bar_quantity_labels[i].visible = true
			action_bar_slot_images[i].texture = load(inventory[i].texture)
		else:
			action_bar_quantity_labels[i].visible = false
			action_bar_slot_images[i].texture = null


# Hides the Chest UI.
func chest_ui_hide():
	Global.player_can_move = true
	$SingleChest.visible = false
	$ActionBar.visible = true
	$Food.visible = true
	$Hearts.visible = true
	$Slots.visible = false
	$XPBar.visible = true


# Displays the Chest UI.
func chest_ui_show():
	Global.play_sound("chest/chestopen")
	Global.player_can_move = false
	$SingleChest.visible = true
	$ActionBar.visible = false
	$Food.visible = false
	$Hearts.visible = false
	$Slots.visible = true
	$XPBar.visible = false


# Hides the Crafting Table UI.
func crafting_table_ui_hide():
	Global.player_can_move = true
	$CraftingTable.visible = false
	$ActionBar.visible = true
	$Food.visible = true
	$Hearts.visible = true
	$Slots.visible = false
	$XPBar.visible = true


# Displays the Crafting Table UI.
func crafting_table_ui_show():
	Global.player_can_move = false
	$CraftingTable.visible = true
	$ActionBar.visible = false
	$Food.visible = false
	$Hearts.visible = false
	$Inventory.visible = false
	$Slots.visible = true
	$XPBar.visible = false


# Clears the highlighted slot for all slots in the Inventory.
func inventory_clear_slot_highlight():
	var slot_range = 36
	for i in slot_range:
		var slot_number = i + 1
		var node_path = "Slots/Slot" + str(slot_number) + "/SlotHighlighted"
		var node = get_node(node_path)
		node.visible = false


# Clears the selected slot frame for all slots in the Inventory.
func inventory_clear_slot_selection():
	var slot_range = 36
	for i in slot_range:
		var slot_number = i + 1
		var node_path = "Slots/Slot" + str(slot_number) + "/SlotSelected"
		var node = get_node(node_path)
		node.visible = false


# Highlights the current slot in the Inventory.
func inventory_show_highlight():
	var node_path = "Slots/Slot" + str(highlighted_slot) +"/SlotHighlighted"
	var node = get_node(node_path)
	node.visible = true


# Sets the textures for each item in the Inventory.
func inventory_slot_textures():
	var inventory = Global.inventory
	inventory = inventory.slice(0,36)
	for i in range(len(inventory)):
		if inventory[i] != null:
			if inventory[i].texture != null:
				inventory_slot_quantity_labels[i].text = str(inventory[i].quantity)
				inventory_slot_quantity_labels[i].visible = true
				inventory_slot_images[i].texture = load(inventory[i].texture)
		else:
			inventory_slot_quantity_labels[i].visible = false
			inventory_slot_images[i].texture = null


# Swaps the items in the Selected slot with the Highlighted slot.
func inventory_swap_slots():
	var highlighted_slot_item = Global.inventory[highlighted_slot-1]
	var selected_slot_item = Global.inventory[selected_slot-1]
	Global.inventory[highlighted_slot-1] = selected_slot_item
	Global.inventory[selected_slot-1] = highlighted_slot_item
	selected_slot = 0
	inventory_clear_slot_selection()
	inventory_slot_textures()
	actionbar_slot_textures()


# Hides the Inventory UI.
func inventory_ui_hide():
	get_tree().paused = false
	highlighted_slot = 0
	selected_slot = 0
	inventory_clear_slot_highlight()
	$ActionBar.visible = true
	$Food.visible = true
	$Hearts.visible = true
	$Inventory.visible = false
	$Slots.visible = false
	$XPBar.visible = true


# Shows the Inventory UI.
func inventory_ui_show():
	get_tree().paused = true
	$ActionBar.visible = false
	$Inventory.visible = true
	$Food.visible = false
	$Hearts.visible = false
	$Slots.visible = true
	$XPBar.visible = false
