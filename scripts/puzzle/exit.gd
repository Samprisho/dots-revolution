extends Node2D

@export var next_level_scene: PackedScene

@onready var area: Area2D = $Area2D

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	

func _on_body_entered(_body = null):
	_next_level.call_deferred()


func _next_level():
	var new_level = next_level_scene.instantiate()

	get_tree().change_scene_to_node(new_level)
