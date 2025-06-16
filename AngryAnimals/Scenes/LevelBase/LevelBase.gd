extends Node2D


const ANIMAL = preload("res://Scenes/Animal/Animal.tscn")

@onready var animal_start: Marker2D = $AnimalStart

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_animal()


func _enter_tree() -> void:
	SignalHub.on_animal_died.connect(spawn_animal)


func spawn_animal() -> void:
	var animal = ANIMAL.instantiate()
	animal.position = animal_start.position
	add_child(animal)
