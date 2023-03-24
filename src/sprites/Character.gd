class_name Character
extends SpriteController

@export var move: int = 5
@export var life: int = 20
@export var strength: int = 5 
@export var magic: int = 5
@export var dexterity: int = 5
@export var speed: int = 5
@export var luck: int = 5
@export var defense: int = 5
@export var resistance: int = 5

var slide_duration: float = 1.2
var start_position: Vector2
var end_position: Vector2
var move_time: float = 0
var is_moving: bool = false

func _get_position() -> Vector2:
	return transform.origin
	
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
	flip_h = false
	play("stand")
	
func _process(delta: float) -> void:
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
		flip_h = false
		if direction.x < 0:
			anim_name += "left"
		elif direction.x > 0:
			anim_name += "right"
			flip_h = true
		elif direction.y < 0:
			anim_name += "up"
		elif direction.y > 0:
			anim_name += "down"
			
		play(anim_name)
