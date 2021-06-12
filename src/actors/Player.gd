extends KinematicBody2D

export (PackedScene) var bullet_scene

export var SPEED = 100
export var COOLDOWN_TIME = 0.1

onready var sprite = $Pivot/ShipSprite
onready var cooldown_timer = $CooldownTimer

var _direction = Vector2.ZERO
var _velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldown_timer.wait_time = COOLDOWN_TIME


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
	
	if Input.is_action_pressed("shoot"):
		if (cooldown_timer.is_stopped()):
			var bullet_instance = bullet_scene.instance()
			get_tree().current_scene.add_child(bullet_instance)
			bullet_instance.global_position = self.global_position - Vector2(0, 10)
			cooldown_timer.start()

func _process_movement(delta: float) -> void:
	move_and_collide(_direction * SPEED * delta)
	
	# Wrapping vertical position on screen
	if global_position.x < -5:
		global_position.x = Global.SCREEN_WIDTH
	if global_position.x > Global.SCREEN_WIDTH + 5:
		global_position.x = 0
	
	if global_position.y > Global.SCREEN_HEIGHT - 5:
		global_position.y = Global.SCREEN_HEIGHT - 5

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

