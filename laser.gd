extends RayCast2D

@export var beam_length: float = 500.0
@export var beam_color: Color = Color.RED
@export var is_casting: bool
@onready var beam_line: Line2D = %Line2D

func _physics_process(delta):
	force_raycast_update()
	if is_colliding():
		var hit_point = to_local(get_collision_point())
		beam_line.points[1] = hit_point
	else:
		beam_line.points[1] = Vector2(0, beam_length)

	# Optional: animate beam length for “firing” effect
	if is_casting:
		beam_line.visible = true
	else:
		beam_line.visible = false
