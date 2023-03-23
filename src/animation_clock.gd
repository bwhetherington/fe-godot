extends Node

var time_elapsed: float = 0.0
var stand_frames: int = 8
var stand_speed: float = 12.0
var animation_index: int = 0

func get_stand_duration() -> float:
	return float(stand_frames) / stand_speed

func _process(delta: float) -> void:
	time_elapsed = fmod(time_elapsed + delta, get_stand_duration())
	animation_index = _get_animation_index()

# This is a hacky attempt at synchronizing animations
func _get_animation_index() -> int:
	var index := int(time_elapsed / get_stand_duration() * stand_frames)
	if index < 3:
		return 0
	if index == 3:
		return 1
	if index < 7:
		return 2
	return 3
