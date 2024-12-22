extends Area2D

signal hit
@onready var label: Label = $Label

var id:int = 0

func _on_area_entered(area: Area2D) -> void:
	if !area.is_in_group("cursor"): return
	hit.emit(self)

func hitTarget():
	print("target hit")
	queue_free()

func finish():
	get_parent().fail()

func setId(v = 0):
	id = v
	label.text = str(v)
