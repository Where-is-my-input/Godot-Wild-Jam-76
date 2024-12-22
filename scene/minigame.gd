extends Node2D

@export var targets:Array[Area2D]

var idCount:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var id = randi_range(0, 3)
	var countdown = randf_range(2.5, 5.5)
	for t in targets:
		t.connect("hit", hit)
		var tween = get_tree().create_tween()
		#tween.tween_property(t, "modulate", Color.RED, 1)
		id = nextId(id)
		t.setId(id)
		#t.scale += Vector2(id / 2, id / 2)
		tween.tween_property(t, "scale", Vector2(), countdown).set_delay(id)
		countdown *= 1.5
		tween.tween_callback(t.finish)

func hit(target):
	if idCount == target.id:
		idCount += 1
		print("Minigame hit")
		print(target)
		target.hitTarget()
		win()
	else:
		fail()

func win():
	var parent = get_parent()
	print(get_child_count())
	if get_child_count() <= 1:
		print("win")
		parent.action()
		qFree()

func fail():
	print("fail")
	qFree()

func nextId(v = 0):
	return v + 1 if v < 3 else 0

func qFree():
	Global.endMinigame()
	get_parent().reset()
	queue_free()
