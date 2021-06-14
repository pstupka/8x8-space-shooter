extends Area2D

export var SPEED = 250

func _physics_process(delta: float) -> void:
	position.y -= SPEED * delta
	if position.y < -10:
		queue_free()
