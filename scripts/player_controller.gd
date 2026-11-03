extends CharacterBody2D

@onready var egg_target: Marker2D = %dotTarget
@onready var dot_container: Node2D = %dotContainer
@onready var rotation_node: Node2D = %rotationNode
@export var speed = 250.0
@export var break_power = 100000

@onready var dot_marker = %dotTarget
var player_vol = Vector2(1,1)
var old_player_pos

const MAX_SPEED = 5000

func _ready() -> void:
	add_to_group("player")
	old_player_pos = global_position

func _set_animation(direction):
	if direction < 0: rotation_node.scale.x = 1
	elif direction > 0: rotation_node.scale.x = -1
	
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
	
	print("dot vel ", velocity.length())

	move_and_slide()
