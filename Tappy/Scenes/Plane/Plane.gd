extends CharacterBody2D


class_name Tappy


signal on_plane_died


const JUMP_POWER: float = -350.0


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var  _gravity: float = ProjectSettings.get("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(_gravity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:	
	fly(delta)
	move_and_slide()	
	if is_on_floor() == true:
		die()

func fly(delta: float) -> void:
	velocity.y += _gravity * delta
	if Input.is_action_just_pressed("jump") == true:
		velocity.y = JUMP_POWER
		animation_player.play("jump")


func die() -> void:
	animated_sprite_2d.stop()
	set_physics_process(false)
	on_plane_died.emit()
