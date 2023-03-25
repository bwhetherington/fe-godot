class_name Character
extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var stats: Stats

var tile: Vector2i = Vector2i(0, 0)
var slide_duration: float = 1.2
var start_position: Vector2
var end_position: Vector2
var move_time: float = 0
var is_moving: bool = false

func _ready() -> void:
	var x = int(transform.origin.x) / 16
	var y = int(transform.origin.y) / 16
	set_tile(x, y)
		
func set_tile(x: int, y: int) -> void:
	sprite.transform.origin = Vector2(x * 16, y * 16)

func _get_position() -> Vector2:
	return sprite.transform.origin
	
func _get_tile_position() -> Vector2i:
	var pos = _get_position()
	return Vector2i(int(pos.x / 16), int(pos.y / 16))
	
func _tile_to_position(tile: Vector2i) -> Vector2:
	return Vector2(tile.x * 16, tile.y * 16)

func _move_to_tile(tile: Vector2i) -> void:	
	start_position = _get_position()
	end_position = _tile_to_position(tile)
	
	if end_position == start_position:
		return
	
	move_time = 0
	is_moving = true
	
func _stop_moving() -> void:
	move_time = 0
	is_moving = false
	sprite.flip_h = false
	sprite.play("stand")
	
func _process(delta: float) -> void:
	if sprite.animation == "stand" or sprite.animation == "active":
		sprite.set_frame(AnimationClock.animation_index)
	if is_moving:
		move_time += delta
		print(move_time)
		
		if move_time >= slide_duration:
			# stop moving
			_stop_moving()
			move_time = slide_duration
		
		transform.origin = start_position.lerp(end_position, move_time / slide_duration)
		if not is_moving:
			return
			
		# Compute direction and play animation
		var direction := end_position - start_position
		var anim_name := "walk_"
		sprite.flip_h = false
		if direction.x < 0:
			anim_name += "left"
		elif direction.x > 0:
			anim_name += "right"
			sprite.flip_h = true
		elif direction.y < 0:
			anim_name += "up"
		elif direction.y > 0:
			anim_name += "down"
			
		sprite.play(anim_name)
