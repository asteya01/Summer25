extends CharacterBody2D


class_name Player


@export var fell_off_y: float = 800.0


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel


const GRAVITY: float = 690.0
const JUMP_SPEED: float = -300.0
const RUN_SPEED: float = 120.0
const MAX_FALL: float = 350.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump") == true:
		velocity.y = JUMP_SPEED
		
	velocity.x = RUN_SPEED * Input.get_axis("left", "right")
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 0 
	
	velocity.y = clampf(velocity.y, JUMP_SPEED, MAX_FALL)
	
	move_and_slide()	
	update_debug_label()	
	fallen_off()
	

func update_debug_label() -> void:
	var ds: String = ""
	ds += "is_on_floor: %s\n" % [is_on_floor()]
	ds += "%.1f, %.1f\n" % [velocity.x, velocity.y]
	ds += "%.1f, %.1f" % [global_position.x, global_position.y]
	debug_label.text = ds

func fallen_off() -> void:
	if global_position.y > fell_off_y:
		queue_free()
