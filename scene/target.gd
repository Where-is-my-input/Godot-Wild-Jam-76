extends Area2D

signal hit

var id:int = 0

func _on_area_entered(area: Area2D) -> void:
	hit.emit(self)

func hitTarget():
	print("target hit")
	queue_free()

func finish():
	get_parent().fail()
