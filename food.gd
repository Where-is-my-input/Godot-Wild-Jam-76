extends TextureRect
@onready var hunger: ProgressBar = $"../stats/hunger"
@onready var freeze: ProgressBar = $"../stats/freeze"
@onready var thirst: ProgressBar = $"../stats/thirst"
@onready var sanity: ProgressBar = $"../stats/sanity"

@export var minFood:int = 5
@export var maxFood:int = 25

@export var foodAmount:int = 30

func action():
	var foodUsed = randi_range(minFood, maxFood)
	hunger.value -= foodUsed
	freeze.value -= foodUsed / 2
	thirst.value += foodUsed / 2 if sanity.value <= 75 else foodUsed
	foodAmount -= foodUsed
	if foodAmount <= 0:
		visible = false
		foodAmount = 0
