extends Node2D

var dir = 0
var bullet_speed = 10

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	var move_dir = Vector2(1,0).rotated(dir)
	global_position += (move_dir * bullet_speed)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
