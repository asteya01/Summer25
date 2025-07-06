extends CharacterBody2D


class_name EnemyBase


const FALL_OF_Y: int = 200.0


@export var points: int = 1
@export var speed: float = 30.0


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var _gravity: float = 800.0
var _player_ref: Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
