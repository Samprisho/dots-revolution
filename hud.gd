extends CanvasLayer

signal start_game

@onready var game_over_label = $GameOverLabel
@onready var start_button = $StartButton

func _ready() -> void:
	game_over_label.hide()
	$Message.hide()
	
func show_game_over():
	$Message.hide()
	game_over_label.text = "GAME OVER"
	game_over_label.show()
	start_button.show()
	
func _on_start_button_pressed():
	game_over_label.hide()
	$Message.hide()
	$StartButton.hide()
	start_game.emit()
	
func new_game() -> void:
	$HUD.show_message("Get Ready!")
	
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$Message.hide()
	
	
