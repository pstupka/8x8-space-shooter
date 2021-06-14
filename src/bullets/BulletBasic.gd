extends Area2D

export var SPEED = 100

func _ready() -> void:
	add_to_group("PlayersBullets")

func _physics_process(delta: float) -> void:
	position.y -= SPEED * delta
	if position.y < -10:
		queue_free()
