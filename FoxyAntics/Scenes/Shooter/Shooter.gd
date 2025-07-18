extends Node2D


class_name Shooter


@export var speed: float = 50.0
@export var shoot_delay: float = 0.7
@export var bullet_key: Constants.ObjectType = \
						Constants.ObjectType.BULLET_PLAYER

@onready var shoot_timer: Timer = $ShootTimer
@onready var sound: AudioStreamPlayer2D = $Sound
	

var _can_shoot: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot_timer.wait_time = shoot_delay


func shoot(direction: Vector2) -> void:
	if _can_shoot == false:
		return
	_can_shoot = false
	SignalHub.emit_on_create_bullet(
		global_position,
		direction,
		speed,
		bullet_key
	)
	shoot_timer.start()
	sound.play()


func _on_shoot_timer_timeout() -> void:
	_can_shoot = true
