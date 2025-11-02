extends EnemyBase


@export var fly_speed: Vector2 = Vector2(35, 15)


@onready var player_detector: RayCast2D = $PlayerDetector
@onready var direction_timer: Timer = $DirectionTimer
@onready var shooter: Shooter = $Shooter


var _fly_direction: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity = _fly_direction
	move_and_slide()
	shoot()
	
	
func shoot()-> void:
	if player_detector.is_colliding() == true:		
		shooter.shoot_at_player()
		
		
func fly_to_player() -> void:
	flip_me()
	var x_dir: float = 1.0 if animated_sprite_2d.flip_h else -1.0
	_fly_direction = Vector2(x_dir, 1) * fly_speed


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	animated_sprite_2d.play("fly")
	direction_timer.start()
	fly_to_player()
	

func _on_direction_timer_timeout() -> void:
	fly_to_player()
