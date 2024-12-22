extends TextureRect
@onready var thirst: ProgressBar = $"../stats/thirst"
@onready var freeze: ProgressBar = $"../stats/freeze"
@onready var sanity: ProgressBar = $"../stats/sanity"

@export var minFood:int = 2
@export var maxFood:int = 12

@export var foodAmount:int = 15

func action():
	var foodUsed = randi_range(minFood, maxFood)
	thirst.value -= foodUsed
	foodAmount -= foodUsed
	freeze.value += foodUsed / 2 if sanity.value <= 75 else foodUsed
	if foodAmount <= 0:
		visible = false
		foodAmount = 0
