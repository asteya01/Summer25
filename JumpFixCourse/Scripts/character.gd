extends CharacterBody2D

@onready var AnimPlayer = $AnimationPlayer
@onready var CharacterSprite = $Sprite2D
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer

#const SPEED = 200
#const JUMP_VELOCITY = -300.0# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#trtrtrt

const ACCELERATION = 3000

var JumpAvailable: bool = true
var JumpBufferActive: bool = false

@export var time_to_jump_peak: float = 0.25
@export var jump_height: int = 64
@export var jump_distance: int = 64

var gravity: float
var jump_velocity: float
var speed: float

func _ready():
	AnimPlayer.play("Idle")
	set_jump_parameters()
	
func set_jump_parameters():
	gravity = (2*jump_height)/pow(time_to_jump_peak,2)
	jump_velocity = -gravity * time_to_jump_peak
	speed = jump_distance/(2*time_to_jump_peak)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if JumpAvailable == true and coyote_timer.is_stopped():
			coyote_timer.start()
	else:
		JumpAvailable = true
		if JumpBufferActive:
			Jump()

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if JumpAvailable: 
			Jump()
		else:
			JumpBufferActive = true
			jump_buffer_timer.start()
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	velocity.x = move_toward(velocity.x, direction*speed, ACCELERATION*delta)
	
	move_and_slide()
	
	ManageAnimations(direction)

func Jump():
		velocity.y = jump_velocity
		JumpAvailable = false


func ManageAnimations(_direction):
	if _direction > 0:
		CharacterSprite.set_flip_h(false)
	if _direction < 0:
		CharacterSprite.set_flip_h(true)
	
	if is_on_floor() && velocity.x != 0:
		AnimPlayer.play("Run")
	elif is_on_floor():
		AnimPlayer.play("Idle")
	elif velocity.y <= 0:
		AnimPlayer.play("JumpUp")
	elif velocity.y >= 0:
		AnimPlayer.play("JumpDown")


func _on_coyote_timer_timeout() -> void:
	JumpAvailable = false


func _on_jump_buffer_timer_timeout() -> void:
	JumpBufferActive = false
