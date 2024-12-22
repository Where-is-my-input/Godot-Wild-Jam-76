extends Area2D

const MINIGAME = preload("res://scene/minigame.tscn")
func _on_area_entered(area: Area2D) -> void:
	if !area.is_in_group("cursor") || Global.minigaming: return
	Global.minigaming = true
	set_deferred("monitoring", false)
	var parent = get_parent()
	var minigame = MINIGAME.instantiate()
	add_child(minigame)
	minigame.global_position += parent.size / 3

func reset():
	set_deferred("monitoring", true)

func action():
	var parent = get_parent()
	if parent.has_method("action"):
		parent.action()
