extends RayCast2D

@export var beam_length: float = 2000.0
@export var beam_color: Color = Color.RED
@export var is_casting: bool
@onready var beam_line: Line2D = %Line2D
@onready var line_2d: Line2D = $Line2d
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	enabled = true
	is_casting = false
	$CycleTimer.start()
	
	while line_2d.get_point_count() < 2:
		line_2d.add_point(Vector2.ZERO)
	
	line_2d.set_point_position(0, Vector2.ZERO)
	line_2d.set_point_position(1, Vector2.ZERO)

func _physics_process(_delta: float):
	target_position = Vector2(beam_length,0)
	
	if is_colliding():
		var local_collision_point: Vector2 = to_local(get_collision_point())
		line_2d.set_point_position(0, Vector2.ZERO)
		line_2d.set_point_position(0, local_collision_point)
		gpu_particles_2d.position = local_collision_point
		gpu_particles_2d.emitting = true
	else:
		line_2d.set_point_position(0, Vector2.ZERO)
		line_2d.set_point_position(0, target_position)
		gpu_particles_2d.emitting = false

func _on_cycle_timer_timeout() -> void:
	is_casting = true
