extends CharacterBody2D


class_name Player


@export var fell_off_y: float = 800.0


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shooter: Shooter = $Shooter
@onready var sound: AudioStreamPlayer2D = $Sound


const GRAVITY: float = 690.0
const JUMP_SPEED: float = -300.0
const RUN_SPEED: float = 120.0
const MAX_FALL: float = 350.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") == true:
		var dir: Vector2 = Vector2.LEFT if sprite_2d.flip_h else \
					Vector2.RIGHT
		shooter.shoot(dir)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump") == true:
		velocity.y = JUMP_SPEED
		sound.play()
		
	velocity.x = RUN_SPEED * Input.get_axis("left", "right")
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 0 
	
	velocity.y = clampf(velocity.y, JUMP_SPEED, MAX_FALL)
	
	move_and_slide()	
	fallen_off()
	

func fallen_off() -> void:
	if global_position.y > fell_off_y:
		queue_free()
