extends Area2D

var dot_scene = preload("res://dots_to_collect.tscn")

func _deffered(plr, new):
	plr.find_child("dotContainer").add_child(new)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(
		func(area: Area2D):
			if area.is_in_group("collectible"):
				print("area")
				var new: Node2D = dot_scene.instantiate()
				var plr = get_tree().get_first_node_in_group("dot")
				new.global_position = area.global_position
				call_deferred("_deffered", plr, new)
				
				await get_tree().process_frame
				area.queue_free()
				
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
