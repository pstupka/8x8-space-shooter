extends Node2D

export (PackedScene) var enemy_scene = preload("res://src/actors/EnemyShip.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_EnemySpawnTimer_timeout():
	var enemy = enemy_scene.instance()
	get_tree().current_scene.add_child(enemy)

	enemy.global_position = $Enemies.global_position
