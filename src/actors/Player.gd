extends KinematicBody2D

export var SPEED = 100

onready var sprite = $Pivot/ShipSprite

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
	
	if Input.is_action_pressed("action"):
		Engine.time_scale = 0.1
	else:
		Engine.time_scale = 1


func _process_movement(delta: float) -> void:
	move_and_collide(_direction * SPEED * delta)
	
	# Wrapping vertical position on screen
	if global_position.x < -5:
		global_position.x = 120
	if global_position.x > 125:
		global_position.x = 0

func _process_animation() -> void:
	if _direction.x == 0:
		$AnimationPlayer.play("run")
	if _direction.x > 0 :
		$AnimationPlayer.play("turn")
		$Pivot/ExhaustSprite.flip_h = true
		$Pivot/ShipSprite.flip_h = true
	if _direction.x < 0:
		$AnimationPlayer.play("turn")
		$Pivot/ExhaustSprite.flip_h = false
		$Pivot/ShipSprite.flip_h = false

