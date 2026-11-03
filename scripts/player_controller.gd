extends CharacterBody2D

@export var speed = 250.0
@export var break_power = 100000
var player_vol = Vector2(1,1)
var old_player_pos

func _ready() -> void:
	old_player_pos = global_position

func _process(delta):
	player_vol = global_position - old_player_pos
	old_player_pos = global_position
	
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
