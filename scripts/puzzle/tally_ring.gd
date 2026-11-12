@tool
extends GoalCondition

@export var time_between_tally: float = 0.500
@export var required_dots: int = 3:
	set(new):
		required_dots = new
		_process_text()
		
@onready var label:	Label = $Label
@onready var area_2d: Area2D = $Area2D

var dots_passed: int = 0
var lastPass: int = Time.get_ticks_msec()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.body_entered.connect(_passed)
	Time.get_ticks_msec()
	_process_text()

func _passed(_body):
	print("passed ", Time.get_ticks_msec(), " vs ", lastPass)
	
	if Time.get_ticks_msec() - lastPass > time_between_tally * 1000:
		if dots_passed > 0:
			dots_passed = 0
		else:
			dots_passed = 1
		incomplete()
	else:
		dots_passed += 1
		if dots_passed >= required_dots:
			complete()
	
	_process_text()
	lastPass = Time.get_ticks_msec()

func _process_text():
	if not label:
		return
	label.text = str(dots_passed) + " / " + str(required_dots)
