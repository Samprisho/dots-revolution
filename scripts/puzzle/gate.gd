extends Goal

@onready var sprite: Sprite2D = $Sprite2D
@onready var static_body_2d: StaticBody2D = $StaticBody2D

func _ready() -> void:
	super()
	prop_activate.connect(func(): sprite.visible = false; static_body_2d.process_mode = Node.PROCESS_MODE_DISABLED)
	prop_deactivate.connect(func(): sprite.visible = true; static_body_2d.process_mode = Node.PROCESS_MODE_INHERIT)
