extends RayCast2D

@export var beam_length: float = 2000.0
@export var beam_color: Color = Color.RED
@export var is_casting: bool
@onready var line_2d: Line2D = $Line2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	enabled = true
	is_casting = false
	$CycleTimer.start(2.0)  # Start with laser ON for 2 seconds
	$CycleTimer.timeout.connect(_on_CycleTimer_timeout)
	$CycleTimer.one_shot = false
	
	
	while line_2d.get_point_count() < 2:
		line_2d.add_point(Vector2.ZERO)
	
	line_2d.set_point_position(0, Vector2.ZERO)
	line_2d.set_point_position(1, Vector2.ZERO)

func _physics_process(_delta: float):
	target_position = Vector2(beam_length,0)
	
	
	if is_casting and is_colliding():
		var local_collision_point: Vector2 = to_local(get_collision_point())
		line_2d.set_point_position(0, Vector2.ZERO)
		line_2d.set_point_position(1, local_collision_point)
		gpu_particles_2d.position = local_collision_point
		gpu_particles_2d.emitting = true
		
		var dot = get_tree().get_first_node_in_group("dot")
		
		var collider = get_collider()
		
		if collider.is_in_group("dot"):
			game_over()
		if collider.is_in_group("dots"):
			game_over()
			
	else:
		line_2d.set_point_position(0, Vector2.ZERO)
		line_2d.set_point_position(1, target_position)
		gpu_particles_2d.emitting = false
	
	


func _on_CycleTimer_timeout():
	if is_casting == true:
		turn_laser_off()
		$CycleTimer.start(4.0)  # OFF for 4 seconds
	else:
		turn_laser_on()
		$CycleTimer.start(2.0)  # ON for 2 seconds
	is_casting = not is_casting

func turn_laser_on():
	line_2d.show()
	gpu_particles_2d.show()
		

func turn_laser_off():
	line_2d.hide()
	gpu_particles_2d.hide()

func game_over():
	SoundPlayer.game_over()
	
	get_tree().reload_current_scene()
	
