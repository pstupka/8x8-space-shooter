extends Area2D

onready var explosion_scene = preload("res://src/misc/Explosion.tscn")

const MAX_TYPE = 36

export var SPEED = 50
export var TYPE = 0

var _direction = Vector2.DOWN
#var _velocity : Vector2

onready var sprite = $Pivot/Sprite


func _ready() -> void:
	sprite.region_rect.position = Vector2((TYPE % 6) * 8, floor(TYPE / 6) * 8 )


func _physics_process(delta: float) -> void:
	self.position += _direction * SPEED * delta
	
	check_bounds()
	

func check_bounds() -> void:
	if global_position.y > Global.SCREEN_HEIGHT:
		queue_free()


func _on_EnemyShip_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayersBullets"):
		var explosion = explosion_scene.instance()
		get_tree().current_scene.add_child(explosion)
		explosion.global_position = self.global_position
		call_deferred("queue_free")
		area.queue_free()
