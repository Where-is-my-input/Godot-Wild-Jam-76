extends CharacterBody2D

@onready var area_shape_2d: CollisionShape2D = $Area2D/areaShape2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	area_shape_2d.set_deferred("disabled", !Input.is_action_just_pressed("interact"))
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	if direction:
		velocity = direction * SPEED
	else:
		#if get_global_mouse_position() != global_position:
			#global_position = get_global_mouse_position()
		#else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		global_position = get_global_mouse_position()
