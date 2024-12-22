extends ColorRect
const SPEED = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	if direction:
		position += direction * SPEED
	#else:
		#position.x = move_toward(position.x, 0, SPEED)
		#position.y = move_toward(position.y, 0, SPEED)
