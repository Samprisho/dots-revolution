extends CanvasLayer

signal start_game

func _ready() -> void:
	pass # Replace with function body.

func show_message(text):
	$Message.text = text
	$Message.show()

func _process(delta: float) -> void:
	pass

func show_game_over():
	show_message("Game Over")

	$Message.text = "Get Ready!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	
func new_game() -> void:
	$HUD.show_message("Get Ready!")
	
	
	
