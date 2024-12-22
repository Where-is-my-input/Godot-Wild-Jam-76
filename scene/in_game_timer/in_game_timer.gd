extends Node

var showTimer = false
var timed = false
var time: float = 0.0
var hours: int = 0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0

var paused:bool = false

func _process(delta):
	if paused: return
	time += delta
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	hours = floor(time / 60 / 60 / 60)

func resetIGT():
	time = 0.0
	hours = 0
	minutes = 0
	seconds = 0
	msec = 0
