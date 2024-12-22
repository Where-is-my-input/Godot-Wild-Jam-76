extends Node

var minigaming:bool = false
var cycle:float = 1.0

func endMinigame():
	await get_tree().create_timer(0.2).timeout
	minigaming = false
