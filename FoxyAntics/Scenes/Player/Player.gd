extends CharacterBody2D

class_name Player

const JUMP = preload("res://assets/sound/jump.wav")
const DAMAGE = preload("res://assets/sound/damage.wav")

@export var fell_off_y: float = 800.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shooter: Shooter = $Shooter
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var hurt_timer: Timer = $HurtTimer


const GRAVITY: float = 690.0
const JUMP_SPEED: float = -300.0
const RUN_SPEED: float = 120.0
const MAX_FALL: float = 350.0
const HURT_JUMP_VELOCITY: Vector2 = Vector2(0, -130.0)


var _is_hurt: bool = false
var _invincible: bool = false


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

	get_input()

	velocity.y = clampf(velocity.y, JUMP_SPEED, MAX_FALL)
	
	move_and_slide()	
	fallen_off()


func play_effect(effect: AudioStream) -> void:
	sound.stop()
	sound.stream = effect
	sound.play()


func get_input() -> void:
	
	if _is_hurt == true:
		return
	
	if is_on_floor() and Input.is_action_just_pressed("jump") == true:
		velocity.y = JUMP_SPEED
		sound.play()
		
	velocity.x = RUN_SPEED * Input.get_axis("left", "right")
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 0 
	

func fallen_off() -> void:
	if global_position.y > fell_off_y:
		queue_free()


func go_invincible() -> void:	
	if _invincible == true:
		return
	_invincible = true
	var tween: Tween = create_tween()
	
	for _i in range(3):
		tween.tween_property(sprite_2d, "modulate", Color("#ffffff", 0.0), 0.5)
		tween.tween_property(sprite_2d, "modulate", Color("#ffffff", 1.0), 0.5)
	tween.tween_property(self, "_invincible", false, 0)


func apply_hurt_jump() -> void:
	_is_hurt = true
	velocity = HURT_JUMP_VELOCITY
	hurt_timer.start()
	play_effect(DAMAGE)


func apply_hit() -> void:
	
	if _invincible == true:
		return
	
	go_invincible()
	apply_hurt_jump()


func _on_hit_box_area_entered(area: Area2D) -> void:
	call_deferred("apply_hit")


func _on_hurt_timer_timeout() -> void:
	_is_hurt = false
