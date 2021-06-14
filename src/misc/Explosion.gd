extends CPUParticles2D

func _ready() -> void:
	emitting = true
	$Timer.start()

func _on_Timer_timeout() -> void:
	call_deferred("queue_free")
