extends Node

var minigaming:bool = false

func endMinigame():
	await get_tree().create_timer(0.2).timeout
	minigaming = false
