extends CharacterBody2D

@onready var AnimPlayer = $AnimationPlayer
@onready var CharacterSprite = $Sprite2D

const SPEED = 200
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const ACCELERATION = 3000

func _ready():
	AnimPlayer.play("Idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	
	velocity.x = move_toward(velocity.x, direction*SPEED, ACCELERATION*delta)
	
	move_and_slide()
	
	ManageAnimations(direction)

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
