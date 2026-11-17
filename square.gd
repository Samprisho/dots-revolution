extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Check collisions
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider.is_in_group("dot") or collider.is_in_group("dots"):
			game_over()

func game_over():
	SoundPlayer.game_over()
	
	get_tree().reload_current_scene()
