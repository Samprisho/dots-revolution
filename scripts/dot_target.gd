@tool
extends Marker2D

@export var dot: CharacterBody2D

@export var range: float = 500
@export var sensitivity: float = 450
@export var default_location: Vector2 = Vector2(-200, 0):
	set(new):
		default_location = new

		position = default_location

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	var input = Vector2(
		Input.get_axis("Dfluenceleft", "Dfluenceright"),
		Input.get_axis("Dfluenceup", "Dfluencedown")
	).normalized()
	
	position += ( input * (sensitivity + dot.velocity.length() * 0.2 ) )  * delta
	
	if position.length() > range:
		position = position.normalized() * range
	
	if Input.is_action_just_pressed("resetDfluence"):
		if position == default_location:
			position = Vector2.ZERO
		elif position != Vector2.ZERO:
			position = default_location
