extends CharacterBody2D

var speed = 0.0
var onTween = false
var stay = false

var collectible_scene = preload("res://scenes/characters/collectible_dot.tscn")

var dot

func _ready() -> void:
	add_to_group("dots")
	dot = get_tree().get_first_node_in_group("dot")

func _bye():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dropDots"):
		if get_index() == 0:
			var newColl: Node2D = collectible_scene.instantiate()
			newColl.global_position = global_position
			get_tree().current_scene.add_child(newColl)
			
			var tween = newColl.create_tween()
			tween.tween_property(newColl, "global_position", dot.dot_marker.global_position, 0.3).set_trans(Tween.TRANS_LINEAR)
			
			var last_dropped = SoundPlayer.time_last_drop
			var time = Time.get_ticks_msec()
			var pitch = SoundPlayer.pitch_drop
			
			print(time - last_dropped)
			
			if time - last_dropped < 500:
				SoundPlayer.pitch_drop = pitch + 0.2
			else:
				SoundPlayer.pitch_drop = 1
			
			SoundPlayer.time_last_drop = time
			SoundPlayer.drop.play()
			
			call_deferred("_bye")
			


func _physics_process(delta: float) -> void:	
	if stay:
		return
	

	var dots = get_tree().get_nodes_in_group("dots")
	
	var dotFloorPos = dot.global_position + Vector2(0,20)
	var lastDotOnFloor = (dots[-1].global_position.y < dotFloorPos.y + 10
		and dots[-1].global_position.y > dotFloorPos.y - 10)
		
	if not lastDotOnFloor or dot.velocity or speed > 0:
		var distanceBetween = lerp(10,200,abs(dot.velocity.x) / dot.speed)
		var targetPos = _get_target_position(dots, dot)
		var direction = (targetPos - global_position).normalized()
		
		if not lastDotOnFloor:
			distanceBetween = 0
		if speed < dot.speed:
			speed = dot.speed
		if dot.velocity == Vector2.ZERO and lastDotOnFloor:
			speed -= 5
		
		if not dot.is_on_floor():
			distanceBetween = 90
		
		
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
	tween.tween_property($Sprite2D, "position", $Sprite2D.position + Vector2(0,-5), 0.2)
	tween.tween_property($Sprite2D, "position", startPos, 0.3)
	await tween.finished
	
	onTween = false
	
	
	
	
	
