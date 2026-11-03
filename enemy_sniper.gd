extends Node2D

var bullet : PackedScene
@onready var player = get_node("res://dot.tscn")

func _ready() -> void:
	bullet = ResourceLoader.load("res://bullet.tscn")
	pass # Replace with function body.

func _process(delta: float) -> void:
	var dist = global_position.distance_to(player.global_position)
	look_at(player.global_position + player.player_vol * (dist/10))
	pass

func _on_timer_timeout() -> void:
	var bull = bullet.instance()
	bull.dir = rotation
	bull.rotation = rotation
	bull.global_position = global_position
	get_parent().add_child(bull)
	pass # Replace with function body.
