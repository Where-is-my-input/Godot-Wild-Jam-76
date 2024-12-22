extends Node2D
@onready var freeze: ProgressBar = $Control/stats/freeze
@onready var sanity: ProgressBar = $Control/stats/sanity
@onready var hunger: ProgressBar = $Control/stats/hunger
@onready var thirst: ProgressBar = $Control/stats/thirst
@onready var timer_tick: Timer = $timerTick

@export var freezeTimerTick:float = 2.0
@export var freezeAmount:int = 3
@export var hungerAmount:int = 2
@export var thirstAmount:int = 1
@export var sanityAmount:int = 5

@onready var mc_frozen: TextureRect = $Control/mc/mc_frozen

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

func _on_timer_tick_timeout() -> void:
	freezeTick()
	mc_frozen.visible = freeze.value > 75
	timer_tick.start(freezeTimerTick if freeze.value < 100 else freezeTimerTick / 2)
