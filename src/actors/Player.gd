extends KinematicBody2D

export var SPEED = 100

var _direction = Vector2.ZERO
var _velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	_process_animation()
	

func _physics_process(delta: float) -> void:
	_process_input(delta)
	_process_movement(delta)


func _process_input(_delta: float) -> void:
	_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)


func _process_movement(delta: float) -> void:
	move_and_collide(_direction * SPEED * delta)


func _process_animation() -> void:
	if _direction.x == 0:
		$ShipSprite.region_rect.position.x = 8
	if _direction.x > 0 :
		$ShipSprite.region_rect.position.x = 16
	if _direction.x < 0:
		$ShipSprite.region_rect.position.x = 0
