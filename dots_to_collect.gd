extends CharacterBody2D

var speed = 0.0
var onTween = false

func _ready() -> void:
	add_to_group("dots")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var dot = get_tree().get_first_node_in_group("dot")
	var dots = get_tree().get_nodes_in_group("dots")
	
	var dotFloorPos = dot.global_position + Vector2(0,20)
	var lastDotOnFloor = (dots[-1].global_position.y < dotFloorPos.y + 10
		and dots[-1].global_position.y > dotFloorPos.y - 10)
		
	if not lastDotOnFloor or dot.velocity or speed > 0:
		var distanceBetween = lerp(10,30,abs(dot.velocity.x) / dot.MAX_SPEED)
		var targetPos = _get_target_position(dots, dot)
		var direction = (targetPos - global_position).normalized()
		
		if not lastDotOnFloor:
			distanceBetween = 0
		if speed < dot.speed:
			speed = dot.speed
		if dot.velocity == Vector2.ZERO and lastDotOnFloor:
			speed -= 5
		if not dot.is_on_floor():
			distanceBetween = 15
		if global_position.distance_to(targetPos) > distanceBetween:
			velocity = direction * speed
		else:
			velocity = Vector2.ZERO
			
		_dot_animation()
		
		move_and_slide()
		
func _get_target_position(dots, dot):
	var dotNumber = get_index()
	
	if dotNumber == 0:
		return dot.dot_marker.global_position
	else:
		return dots[dotNumber - 1].global_position
		
func _dot_animation():
	if onTween: return
	
	onTween = true
	
	var startPos = $Sprite2D.position
	var tween = create_tween()
	tween.tween_property($Sprite2D, "position", $Sprite2D.position + Vector2(0,-1), 0.2)
	tween.tween_property($Sprite2D, "position", startPos, 0.1)
	await tween.finished
	
	onTween = false
	
	
	
	
	
