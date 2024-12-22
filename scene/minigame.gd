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
		t.id = id
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

func win():
	var parent = get_parent()
	if parent.has_method("action") && targets.size() <= 0:
		print("win")
		parent.action()
		queue_free()

func fail():
	print("fail")
	queue_free()

func nextId(v = 0):
	return v + 1 if v < 3 else 0
