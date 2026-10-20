extends CharacterBody2D

@export var speed = 250.0
@export var break_power = 100000



func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	var player_input: Vector2 = Vector2(
		Input.get_axis("playerLeft", "playerRight"),
		Input.get_axis("playerUp", "playerDown")
	).normalized()
	
	if player_input != Vector2.ZERO:
		var movement = player_input * speed
		
		
		#var dotProd = -min(0, velocity.normalized().dot(player_input))
		#var break_force = player_input * dotProd * break_power
		#
		#print(dotProd)
		#
		#var result = movement + break_force
		#
		velocity = movement
	else:
		velocity = Vector2.ZERO

	move_and_slide()
