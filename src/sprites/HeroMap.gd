extends Character

var velocity: Vector2 = Vector2(0, 0)
var tile_speed: float = 48
var color: int = 0

@export var is_character: bool = false

func _process(delta: float) -> void:
	if not is_moving and is_character:
		var target_offset := Vector2i(0, 0)
		if Input.is_action_pressed("ui_left"):
			target_offset.x -= 1
			
		if Input.is_action_pressed("ui_right"):
			target_offset.x += 1
			
		if Input.is_action_pressed("ui_up"):
			target_offset.y -= 1
			
		if Input.is_action_pressed("ui_down"):
			target_offset.y += 1
			
		_move_to_tile(_get_tile_position() + target_offset)

func _input(event: InputEvent) -> void:
	if not is_character:
		return
	
	if event.is_action_pressed("ui_accept"):
		color += 1
		color %= 2
		material.set_shader_parameter("color", color)
