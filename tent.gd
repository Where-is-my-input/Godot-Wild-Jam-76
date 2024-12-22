extends TextureRect
@onready var water: TextureRect = $"../water"
@onready var food: TextureRect = $"../food"
@onready var fireplace: TextureRect = $"../fireplace"

@export var minWater:int = 5
@export var maxWater:int = 15
@export var minFood:int = 10
@export var maxFood:int = 23
@export var minFire:int = 50
@export var maxFire:int = 64

func action():
	match randi_range(0, 3):
		0:
			if !water.visible: water.foodAmount = randi_range(minWater, maxWater)
			water.visible = true
		1:
			if !food.visible: food.foodAmount = randi_range(minFood, maxFood)
			food.visible = true
		2:
			if !fireplace.visible: fireplace.fireAmount = randi_range(minFire, maxFire)
			fireplace.visible = true
		3:
			food.visible = true
			water.visible = true
