@tool
extends GoalCondition
class_name PressurePlate

@export var required_dots: int = 5:
	set(new):
		required_dots = new
		_process_text()
var dots_on_plate: int = 0

@onready var area_2d: Area2D = $Area2D
@onready var label:	Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.body_entered.connect(_scan_bodies)
	area_2d.body_exited.connect(_scan_bodies)
	_process_text()


func _scan_bodies(new_body: Node2D) -> void:
	if not area_2d or not label:
		return
	
	dots_on_plate = 0
	
	for body in area_2d.get_overlapping_bodies():
		dots_on_plate += 1
	
	if dots_on_plate >= required_dots:
		complete()
	else:
		revert()
	
	_process_text()

func _process_text():
	if not label:
		return
	label.text = str(dots_on_plate) + " / " + str(required_dots)
