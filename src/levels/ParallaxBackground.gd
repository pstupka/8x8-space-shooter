extends ParallaxBackground

export var speed_layer_1 = 30
export var speed_layer_2 = 50

func _process(delta: float) -> void:
	$ParallaxLayer2.motion_offset.y += speed_layer_1 * delta
	$ParallaxLayer3.motion_offset.y += speed_layer_2 * delta
