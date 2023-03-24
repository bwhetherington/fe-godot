class_name SpriteController
extends AnimatedSprite2D

func _ready() -> void:
	var x = int(transform.origin.x) / 16
	var y = int(transform.origin.y) / 16
	set_tile(x, y)

# Synchronizes standing animations
func _process(delta: float) -> void:
	print("SpriteController::process")
	if animation == "stand" or animation == "active":
		set_frame(AnimationClock.animation_index)
		
func set_tile(x: int, y: int) -> void:
	transform.origin = Vector2(x * 16, y * 16)
