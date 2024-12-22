extends Node2D
@onready var freeze: ProgressBar = $Control/stats/freeze
@onready var sanity: ProgressBar = $Control/stats/sanity
@onready var hunger: ProgressBar = $Control/stats/hunger
@onready var thirst: ProgressBar = $Control/stats/thirst
@onready var timer_tick: Timer = $timerTick
@onready var timer_weather: Timer = $timerWeather
@onready var fireplace: TextureRect = $Control/fireplace
@onready var bear: TextureRect = $Control/bear
@onready var umbrella: TextureRect = $Control/mc/umbrella
@onready var timer_bear: Timer = $timerBear
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var freezeTimerTick:float = 2.0
@export var freezeAmount:int = 3
@export var hungerAmount:int = 2
@export var thirstAmount:int = 1
@export var sanityAmount:int = 5

@onready var mc_frozen: TextureRect = $Control/mc/mc_frozen
@onready var rain: TextureRect = $Control/rain

var dying = false

func _ready() -> void:
	InGameTimer.resetIGT()
	InGameTimer.paused = false

func freezeTick():
	if hunger.value >= 100:
		freeze.value += freezeAmount 
	else: 
		freeze.value += freezeAmount - hungerAmount
		hunger.value += hungerAmount
	if thirst.value >= 100:
		freeze.value += freezeAmount 
	else: 
		freeze.value += freezeAmount - thirstAmount
		thirst.value += thirstAmount
	if freeze.value >= 50:
		sanity.value += sanityAmount
	if fireplace.fireOn:
		freeze.value -= fireplace.firetick
		sanity.value -= 1
	if bear.visible == true:
		sanity.value += 2
	if rain.visible != umbrella.visible:
		freeze.value += 5
	if dying && freeze.value >= 100:
		InGameTimer.paused = true
		Global.cycle = 1.0
		get_tree().change_scene_to_file("res://scene/game_over.tscn")
	dying = freeze.value >= 100

func _on_timer_tick_timeout() -> void:
	freezeTick()
	mc_frozen.visible = freeze.value > 75
	timer_tick.start(freezeTimerTick if freeze.value < 100 else freezeTimerTick / 2)

func _on_timer_weather_timeout() -> void:
	match randi_range(0,1):
		1:
			rain.visible = true
		_:
			rain.visible = false
	timer_weather.start(60)
	timer_bear.start(30)
	Global.cycle += 0.1
	
	freezeAmount *= Global.cycle
	hungerAmount *= Global.cycle
	sanityAmount *= Global.cycle
	thirstAmount *= Global.cycle


func _on_timer_bear_timeout() -> void:
	match randi_range(0,1):
		1:
			bear.visible = true
		_:
			bear.visible = false

func _on_audio_stream_player_2d_finished() -> void:
	audio_stream_player_2d.play()
