extends TextureRect
@onready var umbrella: TextureRect = $umbrella

func action():
	umbrella.visible = !umbrella.visible
