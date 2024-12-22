extends CanvasLayer
@onready var lbl_igt: Label = $ing_game_timer_control/hbIGT/lblIGT

var noticeBox = 0
var noticeExplanation = ""

func _ready():
	lbl_igt.visible = true
	updateTimer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#updateTimer()

func updateTimer():
	lbl_igt.text = "%02d:" % InGameTimer.hours + "%02d:" % InGameTimer.minutes + "%02d." % InGameTimer.seconds + "%03d" % InGameTimer.msec
