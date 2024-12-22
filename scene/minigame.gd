extends Node2D

@export var targets:Array[Area2D]
@onready var color_rect: ColorRect = $ColorRect
@onready var timer: Timer = $ColorRect/Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $areaTarget/AudioStreamPlayer2D

var steer:Vector2 = Vector2(0,0)

var idCount:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.cycle > 1.0:
		steer = Vector2(randf_range(-0.5, 0.5), randf_range(-0.5, 0.5))
		timer.start(randf_range(0.0, 0.5))
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
	if idCount == target.id && color_rect.color == Color.GREEN:
		idCount += 1
		steer = Vector2(randf_range(1.0, Global.cycle + 1.0), randf_range(1.0, Global.cycle + 1.0))
		target.hitTarget()
		audio_stream_player_2d.play()
		win()
	else:
		fail()

func win():
	var parent = get_parent()
	print(get_child_count())
	if get_child_count() <= 3:
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

func _on_area_target_area_entered(area: Area2D) -> void:
	if area.is_in_group("color"):
		area.get_parent().color = Color.GREEN

func _on_area_target_area_exited(area: Area2D) -> void:
	if area.is_in_group("color"):
		area.get_parent().color = Color.RED


func _on_timer_timeout() -> void:
	color_rect.position += steer
	timer.start(randf_range(0.0, 0.5))


func _on_audio_stream_player_2d_finished() -> void:
	audio_stream_player_2d.play()
