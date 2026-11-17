extends Node

@onready var pick_up = AudioStreamPlayer.new()
@onready var drop = AudioStreamPlayer.new()
@onready var tone = AudioStreamPlayer.new()
@onready var gate = AudioStreamPlayer.new()
@onready var single = AudioStreamPlayer.new()

var _game_over_stream = AudioStreamWAV.load_from_file("res://assets/sfx/explosion.wav")
var _victory_stream = AudioStreamWAV.load_from_file("res://assets/sfx/level_complete.wav")

var time_last_drop: int = 0
var pitch_drop: float = 1:
	set(n):
		pitch_drop = n
		drop.pitch_scale = pitch_drop

var time_last_tone: int = 0
var pitch_tone: float = 1:
	set(n):
		pitch_tone = n
		tone.pitch_scale = pitch_tone


func _ready() -> void:
	add_child(pick_up)
	add_child(drop)
	add_child(single)
	add_child(tone)
	add_child(gate)
	
	gate.stream = AudioStreamWAV.load_from_file("res://assets/sfx/gate_open.wav")
	tone.stream = AudioStreamWAV.load_from_file("res://assets/sfx/presure_plate.wav")
	pick_up.stream = AudioStreamWAV.load_from_file("res://assets/sfx/pickup_dot.wav")
	drop.stream = AudioStreamWAV.load_from_file("res://assets/sfx/drop_dot.wav")
	
	drop.volume_linear = 0.5

func game_over():
	single.stream = _game_over_stream
	single.play()

func victory():
	single.stream = _victory_stream
	single.play()
