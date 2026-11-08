extends Marker2D

@export var dot: CharacterBody2D

@export var range: float = 500
@export var sensitivity: float = 450

func _physics_process(delta: float) -> void:
	var input = Vector2(
		Input.get_axis("Dfluenceleft", "Dfluenceright"),
		Input.get_axis("Dfluenceup", "Dfluencedown")
	).normalized()
	
	position += ( input * (sensitivity + dot.velocity.length() * 0.1 ) )  * delta
	
	if position.length() > range:
		position = position.normalized() * range
	
	if Input.is_action_just_pressed("resetDfluence"):
		position = Vector2.ZERO
