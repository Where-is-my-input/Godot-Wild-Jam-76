extends TextureRect
@onready var fire: TextureRect = $fire
@onready var timer_fire: Timer = $timerFire

var fireOn = false

@export var fireAmount:int = 50

@export var fireMin:int = 15
@export var fireMax:int = 30
@export var firetick:int = 2

func action():
	setFire(true)
	var amount = randi_range(fireMin, fireMax)
	timer_fire.start(amount)
	fireAmount -= amount

func setFire(v = false):
	fire.visible = v
	fireOn = v

func _on_timer_fire_timeout() -> void:
	setFire()
	if fireAmount <= 0:
		visible = false
		fireAmount = 0
